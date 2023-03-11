class Task
  attr_reader :id
  attr_accessor :title, :description

  def initialize(attributes = {})
    @id = attributes[:id]
    @title = attributes[:title]
    @description = attributes[:description]
    @done = attributes[:done] || false
  end

  def done?
    @done
  end

  def done!
    @done = true
  end



  def self.all
    results = DB.execute('SELECT * FROM tasks;')

    tasks = []
    results.each do |result|
      task = Task.new(id: result['id'],
                      title: result['title'],
                      description: result['description'],
                      done: result['done'] == 1 )
      tasks << task
    end
    tasks
  end

  def self.find(id)
    result = DB.execute('SELECT * FROM tasks WHERE id=?', id).first

    Task.new(id: result['id'],
             title: result['title'],
             description: result['description'],
             done: result['done'] == 1)
  end

  def destroy
    DB.execute('DELETE FROM tasks WHERE id=?', @id)
  end

  def save
    @id ? update : create
  end

  private

  def create
    DB.execute('INSERT INTO tasks (title, description, done) VALUES (?, ?, ?)', @title, @description, @done ? 1 : 0)
    @id = DB.last_insert_row_id
  end

  def update
    DB.execute('UPDATE tasks SET title=?, description=?, done=?WHERE id=?', @title, @description, @done ? 1 : 0, @id)
  end
end
