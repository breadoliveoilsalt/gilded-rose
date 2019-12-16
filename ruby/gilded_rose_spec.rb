# require File.join(File.dirname(__FILE__), 'gilded_rose')
require_relative './gilded_rose.rb'


=begin

check out using constants in tests
note the problem with sulfuras

look up ruby freeze


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

    context "for any item" do

      it "does not lower the quality below 0" do
        items = [
          Item.new("Ordinary Item 1", 10, 0), 
          Item.new("Ordinary Item 2", -10, 0)
        ]

        GildedRose.new(items).update_quality()
        
        expect(items[0].quality).to eq 0
        expect(items[1].quality).to eq 0
      end

    end
  
    context "for a non-specialized item" do 

      it "lowers the quality by 1 if it has not expired" do 
        items = [
          Item.new("Ordinary Item 1", 10, 5)
        ]
        
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 4
      end

      it "lowers the quality by 2 if it has expired" do
        items = [
          Item.new("Ordinary Item", -10, 5)
        ]
        
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 3

      end

      it "lowers the sell_in date by 1" do
        items = [
          Item.new("Ordinary Item", 10, 5)
        ]
        
        GildedRose.new(items).update_quality()

        expect(items[0].sell_in).to eq 9
      end

    end

    context "for Aged Brie" do
      
      it "increases the quality of Aged Brie if the quality is less than 50" do
        items = [
          Item.new("Aged Brie", 10, 45)
        ]

        GildedRose.new(items).update_quality()
        
        expect(items[0].quality).to eq 46
      end
      
      it "lowers the sell_in date by 1" do
        items = [
          Item.new("Aged Brie", 10, 45)
        ]

        GildedRose.new(items).update_quality()
        
        expect(items[0].sell_in).to eq 9
      end

    end

    context "Sulfuras" do

      it "does not change the quality of Sulfuras" do
        items = [
          Item.new("Sulfuras, Hand of Ragnaros", 10, 80)
        ]

        GildedRose.new(items).update_quality()
        
        expect(items[0].quality).to eq 80
      end

      it "does not lower the sell_in date for Sulfuras" do
        items = [
          Item.new("Sulfuras, Hand of Ragnaros", 10, 80)
        ]

        GildedRose.new(items).update_quality()
        
        expect(items[0].sell_in).to eq 10
      end
    end
  
  end

end
