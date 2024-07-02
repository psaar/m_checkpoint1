import psycopg2

def db_connection():
    return psycopg2.connect(
        dbname='dictdb',
        user='tester',
        password='secret',
        host="localhost",
        port='5432'
)

def read_dict():
    dbconn = db_connection()
    cur = dbconn.cursor()
    cur.execute("SELECT id, english_word, local_translation FROM dictionary;")
    rows = cur.fetchall()
    cur.close()
    dbconn.close()
    return rows

'''
def add_word():
    dbconn = db_connection()
    cur = dbconn.cursor()
    cur.execute(f'INSERT INTO dictionary (english_word, local_translation) VALUES ({}), ({});')
'''

while True: ## REPL - Read Execute Program Loop
    cmd = input("Command: ")

    if cmd == "list":
        print(read_dict())
    
    elif cmd == "quit":
        exit()
    else:
        print("error")