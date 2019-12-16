# require File.join(File.dirname(__FILE__), 'gilded_rose')
require_relative './gilded_rose.rb'


=begin

"Aged Brie"
"Backstage passes to a TAFKAL80ETC concert"
"Sulfuras, Hand of Ragnaros"
"Conjured"
"Anything else"


{ name: "Something",
  sell_in: int,
  quality: int
}

Both sell_in and quality reduce each day 
But this just seems to update quality

Cap quality at 50.  Except Sulfuras, which is 80 and never alters.
Floor quality at 0.

Quality degrades by -1 each day typically, but -2 if sell_in is < 0
Conjured items degrade twice as fast (by -2, then by -4)
=end

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("fixme", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "fixme"
    end

    context "for a non-specialized item" do 

      it "lowers the quality by 1 if it has not expired" do 
        items = [Item.new("Ordinary Item", 10, 5)]
        
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 4
      end

    end
  
  end

end
