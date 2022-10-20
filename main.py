import json


def dump_sql():
    with open("db_to_add.sql", "w", encoding="utf-8") as f:
        f.write(f"""
CREATE TABLE suppliers (
    id_supplier integer,
    company_name VARCHAR(80),
    name_contact VARCHAR(255),
    position_contact VARCHAR(255),
    country VARCHAR(255),
    states VARCHAR(255),
    address_id VARCHAR(255),
    city VARCHAR(255),
    address VARCHAR(255),
    phone VARCHAR(255),
    fax VARCHAR(255),
    homepage VARCHAR(255)
);
                """)

        f.write(f"""
ALTER TABLE public.products ADD COLUMN fk_supplier INTEGER;\n
        """)

        with open("suppliers.json", "r", encoding="utf-8") as file:
            content = json.load(file)

        count = 0
        for line in content:
            count += 1
            company = (line["company_name"].replace("'", "''") if line["company_name"] != "" else 'NULL')
            name_contact = (line["contact"].split(",")[0].strip() if line["contact"] != "" else 'NULL')
            position_contact = (line["contact"].split(",")[1].strip() if line["contact"] != "" else 'NULL')
            country = (line["address"].split(";")[0].strip() if line["address"].split(";")[0].strip() != "" else 'NULL')
            states = (line["address"].split(";")[1].strip() if line["address"].split(";")[1].strip() != "" else 'NULL')
            address_id = (line["address"].split(";")[2].strip() if line["address"].split(";")[2].strip() != "" else 'NULL')
            city = (line["address"].split(";")[3].strip() if line["address"].split(";")[3].strip() != "" else 'NULL')
            address = (line["address"].split(';')[4].strip().replace("'", "''") if line["address"].split(';')[4].strip() != "" else 'NULL')
            phone = (line["phone"] if line["phone"] != "" else 'NULL')
            fax = (line["fax"] if line["fax"] != "" else 'NULL')
            homepage = (line["homepage"].replace("'", "''") if line["homepage"] != "" else 'NULL')

            f.write(f"""
INSERT INTO suppliers 
VALUES ({count}, '{company}', '{name_contact}', '{position_contact}', '{country}', '{states}','{address_id}', 
'{city}', '{address}','{phone}', '{fax}', '{homepage}');            
            """)

        count = 0
        for line in content:
            count += 1
            product = [p.replace("'", "''") for p in line['products']]
            product = (tuple(product) if len(product) > 1 else f"('{product[0]}')")

            f.write(f"""
UPDATE products SET fk_supplier = {count} WHERE product_name IN {str(product).replace('"', "'")};
            """)

        f.write(f"""
ALTER TABLE ONLY suppliers 
    ADD CONSTRAINT fk_supplier FOREIGN KEY (id_supplier) REFERENCES products;
""")


dump_sql()
