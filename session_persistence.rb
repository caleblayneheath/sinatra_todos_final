class SessionPersistence
  def initialize(session)
    @session = session
    @session[:lists] ||= []
  end

  def find_list(id)
    @session[:lists].find{ |list| list[:id] == id }
  end

  def all_lists
    @session[:lists]
  end

  def create_new_list(list_name)
    id = next_element_id(@session[:lists])           
    @session[:lists] << {id: id, name: list_name, todos: []}   
  end

  def update_list_name(id, list_name)
    list = find_list(id)
    list[:name] = list_name 
  end

  def delete_list(id)
    @session[:lists].reject! { |list| list[:id] == id }
  end

  def create_new_todo(list_id, todo_name)
    list = find_list(list_id)
    id = next_element_id(list[:todos])
    list[:todos] << { id: id, name: todo_name, completed: false }
  end

  def delete_todo_from_list(list_id, todo_id)
    list = find_list(list_id)
    list[:todos].reject! { |todo| todo[:id] == todo_id }
  end

  def update_todo_status(list_id, todo_id, is_completed)
    list = find_list(list_id)
    todo = @list[:todos].find { |todo| todo[:id] == todo_id }
    todo[:completed] = is_completed
  end
  
  def mark_all_todos_completed(list_id)
    list = find_list(list_id)
    list[:todos].each do |todo|
      todo[:completed] = true
    end
  end

  private

  def next_element_id(elements)
    max = elements.map { |todo| todo[:id] }.max || 0
    max + 1
  end
end

