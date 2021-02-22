class MealRepository
  def initialize(file_path)
    @file_path = file_path
    @meals = []
    @next_id = 1
    load_csv if File.exist? @file_path
  end

  def all
    @meals.sort_by{|meal| meal.id}
  end

  def find(id)
    @meals.select{|meal| meal.id == id}.first
  end

  def create(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_csv
  end

  def update(id, new_meal)
    old_meal = find(id)
    @meals.delete(old_meal)
    new_meal.id = id
    @meals << new_meal
    save_csv
  end

  def destroy(id)
    old_meal = find(id)
    @meals.delete(old_meal)
    save_csv
  end

  private

  def save_csv
    CSV.open(@file_path, "wb") do |csv|
      csv << %w[id name price]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    csv_options = {col_sep: ',', quote_char: '"', headers: :first_row, header_converters: :symbol }
    CSV.foreach(@file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      @meals << Meal.new(row)
    end
    @next_id = @meals.last.id + 1 unless @meals.empty?
  end
end

