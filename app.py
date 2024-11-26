from flask import Flask, render_template, request, redirect, url_for, flash
import cx_Oracle

cx_Oracle.init_oracle_client(lib_dir=r"C:\oracle\instantclient-basic-windows.x64-23.6.0.24.10\instantclient_23_6")
app = Flask(__name__)
app.secret_key = 'supersecret'

# Database connection details
dsn_tns = cx_Oracle.makedsn('localhost', '1521', service_name='XE')  #
connection = cx_Oracle.connect(user='system', password='123456', dsn=dsn_tns)

@app.route('/')
def index():
    try:
        cursor = connection.cursor()
        cursor.execute("SELECT coverage_type_id, coverage_name FROM Coverage_Types")
        coverage_types = cursor.fetchall()
        print("Coverage Types Fetched:", coverage_types)  # Debug statement
        cursor.close()
    except Exception as e:
        print("Error fetching coverage types:", e)
        coverage_types = []
    return render_template('index.html', coverage_types=coverage_types)

@app.route('/calculate_quote', methods=['POST'])
def calculate_quote():
    try:
        print("Entered calculate_quote route")  # Debug statement
        # Get form data
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        date_of_birth = request.form['date_of_birth']
        email = request.form['email']
        coverage_type_id = request.form['coverage_type']
        print("Form data received")  # Debug statement

        cursor = connection.cursor()
        print("Database cursor created")  # Debug statement

        # Generate new customer_id using sequence
        cursor.execute("SELECT customer_seq.NEXTVAL FROM dual")
        customer_id = cursor.fetchone()[0]
        print(f"Generated customer_id: {customer_id}")  # Debug statement

        # Insert customer into database
        insert_customer_sql = """
            INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, email)
            VALUES (:1, :2, :3, TO_DATE(:4, 'YYYY-MM-DD'), :5)
        """
        cursor.execute(insert_customer_sql, (customer_id, first_name, last_name, date_of_birth, email))
        connection.commit()
        print("Customer inserted into database")  # Debug statement

        print("Calling stored procedure")  # Debug statement
        quote_amount_var = cursor.var(cx_Oracle.NUMBER)
        cursor.callproc("Insurance_Pkg.calculate_quote", [customer_id, int(coverage_type_id), quote_amount_var])
        print("Stored procedure called")  # Debug statement

        quote_amount = quote_amount_var.getvalue()
        print(f"Quote amount received: {quote_amount}")
        cursor.close()
        print("Database cursor closed")

        return render_template('quote_result.html', quote_amount=quote_amount)
    except Exception as e:
        # Rollback in case of error
        connection.rollback()
        print("Exception occurred:", e)
        flash('An error occurred: ' + str(e))
        return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True)
