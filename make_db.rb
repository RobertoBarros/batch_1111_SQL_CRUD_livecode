require 'sqlite3'

dir = File.dirname(__FILE__)
db = SQLite3::Database.new(File.join(dir, 'database.db'))

db.execute('DROP TABLE IF EXISTS `tasks`;')
create_statement = "CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, done INTEGER DEFAULT (0));"
db.execute(create_statement)

db.execute("INSERT INTO tasks (title, description) VALUES ('Complete Livecode', 'Implement CRUD on Task');")
db.execute("INSERT INTO tasks (title, description) VALUES ('Happy Hour', 'Get a drink, you deserve it');")
