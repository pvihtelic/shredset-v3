Brand.destroy_all
Ski.destroy_all
Store.destroy_all
Inventory.destroy_all
Spec.destroy_all
Image.destroy_all

brand1 = Brand.create(:company=> "Atomic")
brand2 = Brand.create(:company=> "4FRNT")
brand3 = Brand.create(:company=> "Armada")

ski1 = Ski.create(:name=>"Blackeye", :ability_level=>"Intermediate/Advanced", :description=>"Atomic Blackeye Ti Skis + XTO 12 Bindings 2013: The Atomic Blackeye Ti Skis, featuring a modest 82 mm waist width, combine smoothness on-piste with sufficient float in soft snow. All Mountain Rocker in the tip means easy turn initiation and maneuverability from edge to edge while still maintaining total edge contact while on edge. The rocker also allows you to stay much more on top when working in the crud or powder. Make the Atomic Blackeye Ti Skis your new carving ski and you will find that more of the mountain is your playground than ever before. A layer of titanium eats up the vibration when skiing off-piste.", :gender=>"Men's", :model_year=>2013, :rocker_type => "Rocker/camber", :ski_type => "All Mountain", :brand_id => brand1.id)
ski2 = Ski.create(:name=>"Cloud 7", :ability_level=>"Beginner/Intermediate", :description=>"The Atomic Cloud 7 Skis + XTL 9 Lady Bindings will make you love skiing. With a soft flex and narrow waist, the Cloud 7 is an effortless turning ski that will take a beginner and turn them into a happy cruiser. Cap fiber construction makes the Cloud 7 forgiving without requiring a huge amount of energy but allows you to find your edges and experience what carving should feel like.", :gender=>"Women's", :model_year=>2012, :rocker_type => "Camber", :ski_type => "All Mountain", :brand_id => brand1.id) 
ski3 = Ski.create(:name=>"Smoke", :ability_level=>"Beginner/Intermediate", :description=>"Atomic Smoke Ti Skis + XTO 12 Bindings 2013: Perfect for the intermediate exploring the entire mountain, the Atomic Smoke Ti Skis have a 77mm waist that is wide enough to provide a good stable feel on choppy or bumped out snow pack but narrow enough to be effortless on hardpack and groomed snow. Step Down Sidewall construction makes the Smoke Tis forgiving in the tip and tail and when combined with All Mountain Rocker, the slight rise in the tip allows turn initiation in any type of snow with ease and control. A layer of titanium eats up the vibration when skiing off-piste.", :gender=>"Men's", :model_year=>2013, :rocker_type => "Rocker/Camber", :ski_type => "All Mountain", :brand_id => brand1.id)
ski4 = Ski.create(:name=>"CODY", :ability_level=>"Intermediate-Advanced", :description=>"When 4FRNT founder Matt Sterbenz decided to drop his namesake MSP ski and give another deserving skier a shot, he tapped R&D guru Cody Barnhill for the honor. Bucking the big day trend of the other pro models, Cody designed a ski for those slightly less-than-epic sessions where maneuverability and edgehold are more of a factor than float. The 4FRNT CODY Skis are mid-fat skis by today's standards, with waist widths hovering around 100 mm, a mildly rockered tip and tail, and camber under your bindings. This is a great ski for alternating between groomers and slashing through the trees several days after a storm.", :gender=>"Men's", :model_year=>2013, :rocker_type => "Rocker/Camber/Rocker", :ski_type => "All Mountain", :brand_id => brand2.id)
ski5 = Ski.create(:name=>"Bubba", :ability_level=>"Advanced-Expert", :description=>"Like the name suggests, Bubba is Armada's bigger-than-life powder ski. Fat and lovable, Bubba's immense 132 mm waist (188) is made for powder-up-to-your-ears days typically found on cat and heli trips (if you're lucky). This big boy is ready to ride and wants to go on a road trip to Alaska or British Columbia . . . Mayan calendar graphic reminds you to book that heli trip before the end of the world. The Armada Bubba Skis will have you going like there is no tomorrow.", :gender=>"Men's", :model_year=>2013, :rocker_type => "Rocker", :ski_type => "Powder", :brand_id => brand3.id)
ski6 = Ski.create(:name=>"TSTw", :ability_level=>"Intermediate-Advanced", :description=>"The Armada TSTw Skis are the ultimate all mountain, all condition ski and ready for everything from deep pow to corduroy. The TSTw provides the perfect combination of durability and performance for endless fun all winter long. Armada engineered the ideal amount of tip rocker to make sure you can float the light stuff, while giving you a traditionally cambered ski underfoot to make sure you can hold an edge. A portion of the proceeds of each ski go towards the Travis Steeger Memorial Fund.", :gender=>"Women's", :model_year=>2013, :rocker_type => "Rocker/Camber", :ski_type => "All Mountain", :brand_id => brand3.id)

store1 = Store.create(:vendor=>"evo.com", :store_url => "http://www.evo.com/") 
store2 = Store.create(:vendor=>"backcountry.com", :store_url => "http://www.backcountry.com/")	
store3 = Store.create(:vendor=>"rei.com", :store_url => "http://www.rei.com/")	
store4 = Store.create(:vendor=>"skis.com", :store_url => "http://www.skis.com/")	

spec1 = Spec.create(:length => 167, :turning_radius => 25.0, :tip_width => 120, :waist_width => 100, :tail_width => 115, :weight => 2000, :ski_id => ski1.id)
spec2 = Spec.create(:length => 174, :turning_radius => 27.0, :tip_width => 130, :waist_width => 110, :tail_width => 115, :weight => 2000, :ski_id => ski2.id)
spec3 = Spec.create(:length => 180, :turning_radius => 29.0, :tip_width => 130, :waist_width => 120, :tail_width => 125, :weight => 2100, :ski_id => ski1.id)
spec4 = Spec.create(:length => 171, :turning_radius => 23.0, :tip_width => 110, :waist_width => 100, :tail_width => 110, :weight => 1900, :ski_id => ski3.id)
spec5 = Spec.create(:length => 172, :turning_radius => 17.0, :tip_width => 123, :waist_width => 98, :tail_width => 118, :weight => 1700, :ski_id => ski4.id)
spec6 = Spec.create(:length => 179, :turning_radius => 18.0, :tip_width => 126, :waist_width => 100, :tail_width => 122, :weight => 1900, :ski_id => ski4.id)
spec7 = Spec.create(:length => 186, :turning_radius => 19.3, :tip_width => 129, :waist_width => 102, :tail_width => 124, :weight => 2100, :ski_id => ski4.id)
spec8 = Spec.create(:length => 168, :turning_radius => 19.0, :tip_width => 140, :waist_width => 122, :tail_width => 129, :weight => 1900, :ski_id => ski5.id)
spec9 = Spec.create(:length => 178, :turning_radius => 20.0, :tip_width => 145, :waist_width => 127, :tail_width => 134, :weight => 2100, :ski_id => ski5.id)
spec10 = Spec.create(:length => 188, :turning_radius => 21.0, :tip_width => 150, :waist_width => 134, :tail_width => 139, :weight => 2200, :ski_id => ski5.id)
spec11 = Spec.create(:length => 156, :turning_radius => 11.5, :tip_width => 129, :waist_width => 99, :tail_width => 120, :weight => 1400, :ski_id => ski6.id)
spec12 = Spec.create(:length => 165, :turning_radius => 12.6, :tip_width => 130, :waist_width => 100, :tail_width => 121, :weight => 1500, :ski_id => ski6.id)
spec13 = Spec.create(:length => 174, :turning_radius => 14.7, :tip_width => 131, :waist_width => 101, :tail_width => 122, :weight => 1600, :ski_id => ski6.id)

inventories = [
	{ :ski_id => ski1.id, :spec_id => spec1.id, :store_id => store1.id, :product_url => "http://www.evo.com/ski-packages/atomic-blackeye-ti-skis-xto-12-bindings.aspx", :price => 799.00 },
	{ :ski_id => ski1.id, :spec_id => spec3.id, :store_id => store1.id, :product_url => "http://www.evo.com/ski-packages/atomic-blackeye-ti-skis-xto-12-bindings.aspx", :price => 799.00 },
	{ :ski_id => ski3.id, :spec_id => spec4.id, :store_id => store3.id, :product_url => "http://www.rei.com/product/839895/atomic-smoke-ti-skis-with-bindings-mens-20122013", :price => 599.00 },
	{ :ski_id => ski2.id, :spec_id => spec2.id, :store_id => store4.id, :product_url => "http://www.skis.com/Atomic-Cloud-7-Womens-Skis-with-XTL-9-Lightrak-Bindings-2012/227352P,default,pd.html?src=cpc&utm_source=google&utm_medium=cpc&utm_term=&utm_content=pla&utm_campaign=product%2Bads&mr:trackingCode=49CEC662-F9E4-E011-B18D-001B21A69EB0&mr:referralID=NA&mr:adType=pla&mr:ad=18190193121&mr:keyword=&mr:match=&mr:filter=30046702161&gclid=CKWAoILAwLMCFYZaMgodkysA4w", :price => 223.98 },
	{ :ski_id => ski4.id, :spec_id => spec5.id, :store_id => store1.id, :product_url => "http://www.evo.com/skis/4frnt-cody.aspx#image=55915/305633/4frnt-cody-skis-2013-front.jpg", :price => 599.99 },
	{ :ski_id => ski4.id, :spec_id => spec6.id, :store_id => store1.id, :product_url => "http://www.evo.com/skis/4frnt-cody.aspx#image=55915/305633/4frnt-cody-skis-2013-front.jpg", :price => 599.99 },
	{ :ski_id => ski4.id, :spec_id => spec7.id, :store_id => store1.id, :product_url => "http://www.evo.com/skis/4frnt-cody.aspx#image=55915/305633/4frnt-cody-skis-2013-front.jpg", :price => 599.99 },
	{ :ski_id => ski4.id, :spec_id => spec5.id, :store_id => store2.id, :product_url => "http://www.backcountry.com/4frnt-skis-cody-ski", :price => 599.99 },
	{ :ski_id => ski4.id, :spec_id => spec6.id, :store_id => store2.id, :product_url => "http://www.backcountry.com/4frnt-skis-cody-ski", :price => 599.99 },
	{ :ski_id => ski5.id, :spec_id => spec8.id, :store_id => store1.id, :product_url => "http://www.evo.com/skis/armada-bubba.aspx", :price => 799.99 },
	{ :ski_id => ski5.id, :spec_id => spec9.id, :store_id => store1.id, :product_url => "http://www.evo.com/skis/armada-bubba.aspx", :price => 799.99 },
	{ :ski_id => ski5.id, :spec_id => spec10.id, :store_id => store1.id, :product_url => "http://www.evo.com/skis/armada-bubba.aspx", :price => 799.99 },
	{ :ski_id => ski5.id, :spec_id => spec9.id, :store_id => store4.id, :product_url => "http://www.skis.com/Armada-Bubba-Skis-2013/257396P,default,pd.html", :price => 799.95 },
	{ :ski_id => ski5.id, :spec_id => spec10.id, :store_id => store4.id, :product_url => "http://www.skis.com/Armada-Bubba-Skis-2013/257396P,default,pd.html", :price => 799.95 },
	{ :ski_id => ski6.id, :spec_id => spec11.id, :store_id => store1.id, :product_url => "http://www.evo.com/skis/armada-tstw-womens.aspx#image=57872/299200/armada-tstw-skis-women-s-2013.jpg", :price => 649.95 },
	{ :ski_id => ski6.id, :spec_id => spec12.id, :store_id => store1.id, :product_url => "http://www.evo.com/skis/armada-tstw-womens.aspx#image=57872/299200/armada-tstw-skis-women-s-2013.jpg", :price => 649.95 },
	{ :ski_id => ski6.id, :spec_id => spec13.id, :store_id => store1.id, :product_url => "http://www.evo.com/skis/armada-tstw-womens.aspx#image=57872/299200/armada-tstw-skis-women-s-2013.jpg", :price => 649.95 },
	{ :ski_id => ski6.id, :spec_id => spec11.id, :store_id => store4.id, :product_url => "http://www.skis.com/Armada-TSTw-Skis-2013/282249P,default,pd.html?src=cpc&utm_source=google&utm_medium=cpc&utm_term=&utm_content=pla&utm_campaign=product%2Bads&mr:trackingCode=0A8B9E90-CAF8-E111-BFCC-001B21A69EB0&mr:referralID=NA&mr:adType=pla&mr:ad=18190193601&mr:keyword=&mr:match=&mr:filter=30047003961&gclid=CLHJmO-pyLMCFexAMgodfzoA5w", :price => 649.95 },
	{ :ski_id => ski6.id, :spec_id => spec12.id, :store_id => store4.id, :product_url => "http://www.skis.com/Armada-TSTw-Skis-2013/282249P,default,pd.html?src=cpc&utm_source=google&utm_medium=cpc&utm_term=&utm_content=pla&utm_campaign=product%2Bads&mr:trackingCode=0A8B9E90-CAF8-E111-BFCC-001B21A69EB0&mr:referralID=NA&mr:adType=pla&mr:ad=18190193601&mr:keyword=&mr:match=&mr:filter=30047003961&gclid=CLHJmO-pyLMCFexAMgodfzoA5w", :price => 649.95 }	
]

images = [
	{ :image_url => "http://www.evo.com/imgp/750/58059.Size.LengthCM_167_Image.jpg", :ski_id => ski1.id},
	{ :image_url => "http://images.edgeandwax.co.uk/images/13-atomic-blackeye-crop.jpg?height=450&width=340", :ski_id => ski1.id},
	{ :image_url => "http://www.evo.com/imgp/750/44775.Size.LengthCM_142_Image.jpg", :ski_id => ski2.id},
	{ :image_url => "http://www.evo.com/imgp/750/42924.Size.LengthCM_150_Image.jpg", :ski_id => ski3.id},
	{ :image_url => "http://www.evo.com/imgp/750/55915/305633/4frnt-cody-skis-2013-front.jpg", :ski_id => ski4.id},
	{ :image_url => "http://www.backcountry.com/images/items/900/FTS/FTS0079/ONECOL.jpg", :ski_id => ski4.id},
	{ :image_url => "http://www.evo.com/imgp/750/54224/305867/armada-bubba-skis-2013-front.jpg", :ski_id => ski5.id},
	{ :image_url => "http://www.evo.com/imgp/750/57872/299200/armada-tstw-skis-women-s-2013.jpg", :ski_id => ski6.id}
]


Inventory.create inventories
Image.create images