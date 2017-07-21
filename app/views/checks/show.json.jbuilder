if @balance
  json.partial! "checks/check", balance: @balance
end
