module Rag
  module Array
    def extract_columns(*args)
      args.map { |i| self[i] }
    end
  end
end