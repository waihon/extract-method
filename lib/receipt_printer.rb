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
    subtotal = items.reduce(0) do |sum, item|
      item_cost = COST[item]
      output.puts line(label: item, amount: item_cost)

      sum + item_cost.to_i
    end

    output.puts divider
    output.puts line(label: "subtotal", amount: subtotal)
    output.puts line(label: "tax", amount: subtotal * TAX)
    output.puts divider
    output.puts "total: #{sprintf('$%.2f', subtotal + (subtotal * TAX))}"
  end

  private

  attr_reader :output, :items

  def divider
    '-' * 13
  end

  def line(label:, amount:)
    "#{label}: #{sprintf('$%.2f', amount)}"
  end
end