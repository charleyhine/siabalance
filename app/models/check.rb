class Check
  include ActiveModel::Model

  attr_accessor :addresses
  validates_presence_of :addresses

  def balance
    balance = 0.0
    addresses_to_a.each { |address| balance += address_balance(address) }
    balance
  end

  def addresses_to_a
    self.addresses.include?(",") ? self.addresses.split(",") : self.addresses.split("\r\n")
  end

  private

    def address_balance(address)
      balance = 0.0
      resp = HTTParty.get("http://explore.sia.tech/explorer/hashes/#{address}")
      body = JSON.parse(resp.body)

      if txs = body['transactions']
        txs.each do |tx|

          if ios = tx['siacoininputoutputs']
            ios.each do |io|
              balance -= value_to_d(io['value']) if io['unlockhash'] == address
            end
          end

          if outs = tx['rawtransaction']['siacoinoutputs']
            outs.each do |out|
              balance += value_to_d(out['value']) if out['unlockhash'] == address
            end
          end

        end
      end

      balance
    end

    def value_to_d(string)
      begin
        string.insert(-25, '.').to_d
      rescue
        0.0 # dust
      end
    end
end
