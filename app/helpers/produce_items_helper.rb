module ProduceItemsHelper
  def produce_items_for_select
    ProduceItem.all.collect { |i| [i.name, i.id] }
  end
end
