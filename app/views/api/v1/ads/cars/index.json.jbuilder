json.data do
  json.array! @cars, partial: 'car', as: :car
end
json.page do
  json.total @cars.total_pages
  json.current @cars.current_page
  json.next @cars.next_page
  json.prev @cars.prev_page
end