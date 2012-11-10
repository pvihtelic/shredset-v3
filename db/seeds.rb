Brand.destroy_all
Ski.destroy_all
Store.destroy_all
Inventory.destroy_all

brand1 = Brand.create(:company=> "Atomic")


ski1 = Ski.create(:name=>"Blackeye", :ability_level=>"Intermediate/Advanced", :description=>"Atomic Blackeye Ti Skis + XTO 12 Bindings 2013: The Atomic Blackeye Ti Skis, featuring a modest 82 mm waist width, combine smoothness on-piste with sufficient float in soft snow. All Mountain Rocker in the tip means easy turn initiation and maneuverability from edge to edge while still maintaining total edge contact while on edge. The rocker also allows you to stay much more on top when working in the crud or powder. Make the Atomic Blackeye Ti Skis your new carving ski and you will find that more of the mountain is your playground than ever before. A layer of titanium eats up the vibration when skiing off-piste.", :gender=>"Men's", :model_year=>2013, :rocker_type => "Rocker/camber", :ski_type => "All Mountain", :brand_id => brand1.id)
ski2 = Ski.create(:name=>"Cloud 7", :ability_level=>"Beginner/Intermediate", :description=>"The Atomic Cloud 7 Skis + XTL 9 Lady Bindings will make you love skiing. With a soft flex and narrow waist, the Cloud 7 is an effortless turning ski that will take a beginner and turn them into a happy cruiser. Cap fiber construction makes the Cloud 7 forgiving without requiring a huge amount of energy but allows you to find your edges and experience what carving should feel like.", :gender=>"Women's", :model_year=>2012, :rocker_type => "Camber", :ski_type => "All Mountain", :brand_id => brand1.id) 
ski3 = Ski.create(:name=>"Smoke", :ability_level=>"Beginner/Intermediate", :description=>"Atomic Smoke Ti Skis + XTO 12 Bindings 2013: Perfect for the intermediate exploring the entire mountain, the Atomic Smoke Ti Skis have a 77mm waist that is wide enough to provide a good stable feel on choppy or bumped out snow pack but narrow enough to be effortless on hardpack and groomed snow. Step Down Sidewall construction makes the Smoke Tis forgiving in the tip and tail and when combined with All Mountain Rocker, the slight rise in the tip allows turn initiation in any type of snow with ease and control. A layer of titanium eats up the vibration when skiing off-piste.", :gender=>"Men's", :model_year=>2013, :rocker_type => "Rocker/camber", :ski_type => "All Mountain", :brand_id => brand1.id)

store1 = Store.create(:vendor=>"evo.com", :store_url => "http://www.evo.com/") 
store2 = Store.create(:vendor=>"backcountry.com", :store_url => "http://www.backcountry.com/")	
store3 = Store.create(:vendor=>"rei.com", :store_url => "http://www.rei.com/")	
store4 = Store.create(:vendor=>"skis.com", :store_url => "http://www.skis.com/")	


spec1 = Spec.create(:length => 167, :turning_radius => 25.0, :tip_width => 120, :waist_width => 100, :tail_width => 115, :weight => 2000, :ski_id => ski1.id)
spec2 = Spec.create(:length => 174, :turning_radius => 27.0, :tip_width => 130, :waist_width => 110, :tail_width => 115, :weight => 2000, :ski_id => ski2.id)
spec3 = Spec.create(:length => 180, :turning_radius => 29.0, :tip_width => 130, :waist_width => 120, :tail_width => 125, :weight => 2100, :ski_id => ski1.id)
spec4 = Spec.create(:length => 171, :turning_radius => 23.0, :tip_width => 110, :waist_width => 100, :tail_width => 110, :weight => 1900, :ski_id => ski3.id)


inventories = [
	{ :ski_id => ski1.id, :spec_id => spec1.id, :store_id => store1.id, :product_url => "http://www.evo.com/ski-packages/atomic-blackeye-ti-skis-xto-12-bindings.aspx", :price => 799.00 },
	{ :ski_id => ski1.id, :spec_id => spec2.id, :store_id => store1.id, :product_url => "http://www.evo.com/ski-packages/atomic-blackeye-ti-skis-xto-12-bindings.aspx", :price => 799.00 },
	{ :ski_id => ski3.id, :spec_id => spec3.id, :store_id => store3.id, :product_url => "http://www.rei.com/product/839895/atomic-smoke-ti-skis-with-bindings-mens-20122013", :price => 599.00 },
	{ :ski_id => ski2.id, :spec_id => spec2.id, :store_id => store4.id, :product_url => "http://www.skis.com/Atomic-Cloud-7-Womens-Skis-with-XTL-9-Lightrak-Bindings-2012/227352P,default,pd.html?src=cpc&utm_source=google&utm_medium=cpc&utm_term=&utm_content=pla&utm_campaign=product%2Bads&mr:trackingCode=49CEC662-F9E4-E011-B18D-001B21A69EB0&mr:referralID=NA&mr:adType=pla&mr:ad=18190193121&mr:keyword=&mr:match=&mr:filter=30046702161&gclid=CKWAoILAwLMCFYZaMgodkysA4w", :price => 223.98 },
	{ :ski_id => ski3.id, :spec_id => spec4.id, :store_id => store2.id, :product_url => "http://www.skis.com/Atomic-Cloud-7-Womens-Skis-with-XTL-9-Lightrak-Bindings-2012/227352P,default,pd.html?src=cpc&utm_source=google&utm_medium=cpc&utm_term=&utm_content=pla&utm_campaign=product%2Bads&mr:trackingCode=49CEC662-F9E4-E011-B18D-001B21A69EB0&mr:referralID=NA&mr:adType=pla&mr:ad=18190193121&mr:keyword=&mr:match=&mr:filter=30046702161&gclid=CKWAoILAwLMCFYZaMgodkysA4w", :price => 275.00}
]

images = [
	{ :image_url => "http://www.evo.com/imgp/750/58059.Size.LengthCM_167_Image.jpg", :ski_id => ski1.id},
	{ :image_url => "http://images.edgeandwax.co.uk/images/13-atomic-blackeye-crop.jpg?height=450&width=340", :ski_id => ski1.id},
	{ :image_url => "http://www.evo.com/imgp/750/44775.Size.LengthCM_142_Image.jpg", :ski_id => ski2.id},
	{ :image_url => "http://www.evo.com/imgp/750/42924.Size.LengthCM_150_Image.jpg", :ski_id => ski3.id}
]


Inventory.create inventories
Image.create images