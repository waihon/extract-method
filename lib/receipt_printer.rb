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
    output_divider
    output_subtotals
    output_divider
    output_total
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

  def item_lines
    items.each do |item|
      output_with label: item, cost: item_cost(item)
    end
  end

  def output_subtotals
    subtotal_line
    tax_line
  end

  def subtotal_line
    output_with label: "subtotal", cost: subtotal
  end

  def tax_line
    output_with label: "tax",cost: tax(amount: subtotal)
  end

  def output_total
    total_line
  end

  def total_line
    output_with label: "total", cost: total(amount: subtotal)
  end

  def output_divider
    divider_line
  end

  def divider_line
    output.puts divider
  end
end
