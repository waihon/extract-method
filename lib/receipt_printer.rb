class ReceiptPrinter
  COST = {
    'meat' => 5,
    'milk' => 3,
    'candy' => 1,
  }

  TAX = 0.05

  def initialize(output: $stdout, items:)
    @output = output
    @items = items
  end

  def print
    output_items

    output.puts divider
    output_subtotals
    output.puts divider
    output_with label: "total", cost: total(amount: subtotal)
  end

  private

  attr_reader :output, :items

  def divider
    '-' * 13
  end

  def tax(amount:)
    amount * TAX
  end

  def total(amount:)
    amount + (amount * TAX)
  end

  def output_with(label:, cost:)
    output.puts "#{label}: #{sprintf('$%.2f', cost)}"
  end

  def item_cost(item)
    COST[item]
  end

  def subtotal
    @_subtotal ||= items.reduce(0) do |sum, item|
      sum + item_cost(item)
    end
  end

  def output_items
    items.each do |item|
      output_with label: item, cost: item_cost(item)
    end
  end

  def output_subtotals
    output_with label: "subtotal", cost: subtotal
    output_with label: "tax",cost: tax(amount: subtotal)
  end

  def output_total
    output_with label: "total", cost: total(amount: subtotal)
  end
end
