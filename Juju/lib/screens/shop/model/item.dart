class Item {
  final String id;
  final String name;
  final String category;
  final String seller;
  final String origin;
  final String description;
  final String sold;
  final String stock;
  final String price;
  final String img;
  final String discount;
  final String rating;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.seller,
    required this.origin,
    required this.description,
    required this.sold,
    required this.stock,
    required this.price,
    required this.img,
    required this.discount,
    required this.rating,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      seller: json['seller'],
      origin: json['origin'],
      description: json['description'],
      sold: json['sold'],
      stock: json['stock'],
      price: json['price'],
      img: json['img'],
      discount: json['discount'],
      rating: json['rating'],
    );
  }
}

List<Item> itemList = [
  Item(
    id: "item001",
    name: "Jeju Crayon",
    category: "souvenir",
    seller: "Sagye Saenghwal",
    origin:
        "Jeju Crayon is a unique and eco-friendly art tool crafted from the natural beauty of Jeju Island. Made from volcanic ash and other organic materials found on the island, these crayons are not just tools for drawing—they are a piece of Jeju’s landscape. Each crayon carries the vibrant colors inspired by Jeju’s stunning scenery: the deep blues of the ocean, the lush greens of Hallasan Mountain, and the earthy tones of its volcanic soil. Jeju Crayons are non-toxic and safe for both children and adults, embodying the island’s commitment to sustainability and creativity",
    description:
        "ODUJEJ, a company creating object using materials unique to Jeju, came up with this crayon set inspired by Jeju’s stone mounds. Jeju stones’ texture and colors were brought to life using Jeju beeswax and natural mineral pigments.",
    sold: "300",
    stock: "23",
    price: "22.55",
    img: "https://i.ibb.co/cL4D0Rt/crayon.jpg",
    discount: "5",
    rating: "4",
  ),
  Item(
    id: "item002",
    name: "Dol Hareubang Candle",
    category: "souvenir",
    seller: "By Jeju",
    origin:
        "The Dol Hareubang Candle is a beautifully crafted homage to Jeju Island’s iconic stone statues, Dol Hareubang, which symbolize protection and fertility. Made from high-quality, natural wax, this candle captures the distinct look of the traditional volcanic stone figures, known for their large eyes, flat noses, and serene expressions. Often infused with Jeju-inspired fragrances such as tangerine blossom or cedarwood, the Dol Hareubang Candle offers a calming ambiance, making it both a decorative piece and a sensory experience. Its design reflects the spirit of Jeju’s cultural heritage, bringing warmth and a touch of the island’s charm to any space.",
    description:
        "When lighting this candle, one feels as if they are back in Jeju. Dol Hareubang refers to stone sculptures erected outside government offices in Jeju in the old days. These stone sculptures stood as guardians of the island in the past, and now lend their appearances to souvenirs of Jeju.",
    sold: "40",
    stock: "45",
    price: "11.27",
    img: "https://i.ibb.co/d277P6q/candle.jpg",
    discount: "10",
    rating: "4",
  ),
  Item(
    id: "item003",
    name: "Mongdol Natural Soap",
    category: "souvenir",
    seller: "Sagye Saenghwal",
    origin:
        "Mongdol Natural Soap is a premium skincare product handcrafted from the pure, mineral-rich volcanic stones (mongdol) found along the shores of Jeju Island. Infused with natural ingredients sourced from Jeju, such as green tea, volcanic ash, and citrus extracts, this soap offers a gentle yet effective cleansing experience. The volcanic properties help to exfoliate and detoxify the skin, removing impurities while maintaining moisture balance. Known for its soothing and skin-nourishing qualities, Mongdol Natural Soap not only rejuvenates the skin but also evokes the fresh, clean essence of Jeju’s pristine coastline",
    description:
        "This cute soap is formulated by experts with charcoal, seaweed extract, and other ingredients that are excellent for removing oil from the skin, without the use of artificial additives such as surfactants, artificial flavors, colors, and preservatives.",
    sold: "100",
    stock: "67",
    price: "7.52",
    img: "https://i.ibb.co/j6Ydr62/soap.jpg",
    discount: "3",
    rating: "4",
  ),
  Item(
    id: "item004",
    name: "Jeju Toothpaste",
    category: "souvenir",
    seller: "Sagye Saenghwal",
    origin:
        "Jeju Toothpaste is a refreshing, natural oral care product infused with the essence of Jeju Island’s rich environment. Made from ingredients like Jeju green tea extract, tangerine peel, and volcanic mineral powder, this toothpaste provides a gentle yet thorough cleaning experience. Its natural properties help to remove plaque and brighten teeth while maintaining gum health. The volcanic minerals act as a mild abrasive, polishing teeth without causing sensitivity, while the green tea and tangerine offer a fresh, invigorating taste. Jeju Toothpaste captures the purity and vitality of the island, promoting a clean, healthy smile with every brush.",
    description:
        "The smooth and refreshing feel of 1950 Toothpaste products were developed with Jeju's native herbs, Jeju volcanic seawater, Jeju organic lemon, and tangerine peel.",
    sold: "60",
    stock: "34",
    price: "7.52",
    img: "https://i.ibb.co/vJyM0Pk/toothpaste.jpg",
    discount: "15",
    rating: "4",
  ),
  Item(
    id: "item006",
    name: "Jeju Shirts, Trousers, and Dresses",
    category: "souvenir",
    seller: "Scene of Jeju",
    origin:
        "Jeju Shirts, Trousers, and Dresses are clothing pieces that beautifully reflect the natural charm and cultural essence of Jeju Island. Made from lightweight, breathable fabrics like organic cotton and linen, these garments are perfect for Jeju's mild, breezy climate. The designs often incorporate soft, neutral tones inspired by the island’s landscapes—such as the blues of the ocean, the greens of the tea fields, and the earthy tones of volcanic rocks.",
    description:
        "These products are made by the brand Scene of Jeju and Jeju farmers, using tangerines that cannot be sold on the market. Plus, they feel great against your body, using only natural fibers grown and produced without pesticides or chemical fertilizers. Their eco-friendly consciousness delivers the feeling of wearing Jeju’s pristine nature on one’s skin.",
    sold: "10",
    stock: "8",
    price: "60.00",
    img: "https://i.ibb.co/j3c7m02/shirts.jpg",
    discount: "25",
    rating: "4",
  ),
  Item(
    id: "item007",
    name: "Jeju Hat and Scarf",
    category: "souvenir",
    seller: "Muldeuryeon Massim",
    origin:
        "The Jeju Hat and Scarf are stylish, eco-conscious accessories that draw inspiration from Jeju Island’s natural beauty and rich cultural heritage. The Jeju Hat is often made from natural fibers such as hemp, cotton, or even woven materials derived from Jeju's iconic volcanic basalt, creating a lightweight and breathable design perfect for shielding against the sun or providing warmth in cooler weather. Its wide brim or simple, minimalistic shape reflects the island’s relaxed lifestyle, while earthy tones or subtle patterns are reminiscent of Jeju’s serene landscapes, from its windswept coastlines to the vibrant green of its tea fields.",
    description:
        "“Muldeuryeon Massim” grows and harvests tangerines and other ingredients to create naturally dyed products like hats and scarves.",
    sold: "50",
    stock: "46",
    price: "26.30",
    img: "https://i.ibb.co/NTX3Xt0/hat.jpg",
    discount: "20",
    rating: "4",
  ),
  Item(
    id: "item008",
    name: "Jeju Eco Bag",
    category: "souvenir",
    seller: "Haenyeo Museum",
    origin:
        "The Jeju Eco Bag is a sustainable and stylish accessory designed to reflect the natural beauty and eco-conscious spirit of Jeju Island. Made from durable, environmentally friendly materials such as organic cotton, recycled fibers, or even Jeju’s unique volcanic stone-infused fabric, this bag is perfect for daily use, whether for shopping, travel, or casual outings. Its minimalist design often features earthy tones, inspired by Jeju's landscapes, or subtle prints of local symbols like tangerines, Dol Hareubang statues, or the island’s iconic horses.",
    description:
        "Among the various Haenyeo merch sold in the Haenyeo Museum shop, the eco bag stands out. It captures the feeling of Jeju with its Haenyeo illustration. The bag is soft and smooth, which, coupled with the cute Haenyeo illustration, cheers you up right away as you shoulder the bag.",
    sold: "250",
    stock: "98",
    price: "7.52",
    img: "https://i.ibb.co/DkS1tHC/bag.jpg",
    discount: "40",
    rating: "4",
  ),
  Item(
    id: "item009",
    name: "Jeju Pendant, Bracelet, and Brooch",
    category: "souvenir",
    seller: "Sumbi Island",
    origin:
        "The Jeju Pendant, Bracelet, and Brooch are exquisite jewelry pieces inspired by the island’s natural wonders and cultural heritage. Each accessory is thoughtfully crafted from materials unique to Jeju, such as volcanic basalt, tangerine wood, or seashells, symbolizing the island's connection to nature. The Jeju Pendant often features delicate designs, from miniature Dol Hareubang figures to abstract shapes inspired by the waves of Jeju's coastline or the lush greenery of Hallasan Mountain. Worn close to the heart, it adds a subtle yet meaningful touch to any outfit, evoking the island’s peaceful beauty. The Jeju Bracelet is typically made with natural stones, lava beads, or wooden elements, each bead symbolizing a part of Jeju’s landscape, from its volcanic heritage to its vibrant flora. Designed for comfort and style, the bracelet often carries a grounding energy, reflecting Jeju’s harmony with nature. The Jeju Brooch, on the other hand, is a bold statement piece. Featuring intricate carvings or detailed depictions of Jeju’s iconic tangerines, haenyeo divers, or even volcanic craters, the brooch is both a fashionable and cultural accessory. Pinned onto a jacket or scarf, it serves as a conversation piece that celebrates Jeju’s unique identity.",
    description:
        "How can Haenyeo be so cute? “Sumbi Island,” a place known for its Haenyeo character offerings, is home to truly a staggering variety of Haenyeo products. Pendants, bracelets, and brooches, in particular, are popular for their cutesy Haenyeo character design. The design includes diving Haenyeo, Haenyeo holding a tewak, and even the dolphins of Jeju.",
    sold: "150",
    stock: "121",
    price: "3.76",
    img: "https://i.ibb.co/j6sP0g0/pendant.jpg",
    discount: "10",
    rating: "4",
  ),
  Item(
    id: "item010",
    name: "Tewak Handicraft",
    category: "souvenir",
    seller: "Haenyeo Museum",
    origin:
        "Tewak Handicraft not only serves practical purposes but also acts as a celebration of Jeju’s nature and history. These unique items carry the warmth of handmade artistry, making them perfect for both personal use and as meaningful gifts or souvenirs. Embracing the spirit of sustainability, many Tewak handicrafts are made with eco-friendly practices, ensuring that they honor and preserve the natural beauty of Jeju Island for generations to come",
    description:
        "Tewak is a must-have tool for divers. When diving underwater, Haenyeo place this equipment on their chest so that their body can float upward. Because of its importance as a life-saving gear, tewak takes on a symbolic importance to Haenyeo, who are, in turn, symbols of Jeju.",
    sold: "10",
    stock: "7",
    price: "15.03",
    img: "https://i.ibb.co/nzddvH7/tewak.jpg",
    discount: "5",
    rating: "4",
  ),
  Item(
    id: "item011",
    name: "Jeju Tangerine Hat",
    category: "souvenir",
    seller: "By Jeju",
    origin:
        "The Jeju Tangerine Hat is a vibrant and playful accessory inspired by Jeju Island’s famous tangerine orchards. Made from high-quality, breathable materials like cotton or straw, this hat often features an eye-catching design, with bright orange hues or tangerine patterns reminiscent of the island’s signature fruit. Lightweight and comfortable, the hat is perfect for sunny days, offering protection from the sun while adding a cheerful, stylish touch to your outfit.",
    description:
        "When you are in Jeju, you often run into people wearing orange hats. These hats come with a stem, perfectly recreating tangerines and making them the most Jeju of all merch.",
    sold: "80",
    stock: "67",
    price: "7.52",
    img: "https://i.ibb.co/5np20bR/hat.png",
    discount: "15",
    rating: "4",
  ),
  Item(
    id: "item012",
    name: "Tangerine Drip Coffee",
    category: "food",
    seller: "Jeju Basalt",
    origin:
        "Tangerine Drip Coffee is a unique and refreshing blend that captures the essence of Jeju Island’s famous tangerines in a delightful coffee experience. Made by infusing high-quality Arabica beans with the subtle citrus notes of Jeju’s sun-ripened tangerines, this drip coffee offers a balanced flavor profile that’s both bright and smooth. The natural sweetness and zesty aroma of the tangerines complement the rich, bold taste of the coffee, creating a distinctive brew that’s refreshing yet full-bodied.",
    description:
        "Tangerine drip coffee combines Brazilian and Guatemalan coffee beans with tangerines, and this creates a cup coffee front-ended by the deep flavors of the beans before being rounded out with the fragrance of tangerines.",
    sold: "100",
    stock: "78",
    price: "7.52",
    img: "https://i.ibb.co/PZXmW0Q/coffee.png",
    discount: "20",
    rating: "4",
  ),
  Item(
    id: "item013",
    name: "Tangerine Juice and Chips",
    category: "food",
    seller: "By Jeju",
    origin:
        "Tangerine Juice is made from the freshest, sun-ripened tangerines grown in Jeju’s fertile volcanic soil, capturing the pure essence of the island’s citrus heritage. The juice is naturally sweet and tangy, bursting with vitamins and antioxidants, making it a healthy and invigorating drink. Its bright, refreshing flavor brings a taste of Jeju’s sunny orchards in every sip, whether enjoyed chilled on a hot day or paired with meals. With no added sugars or preservatives, Jeju Tangerine Juice delivers a truly natural, guilt-free beverage that celebrates the island’s agricultural richness.",
    description:
        "Tangerine juice or tangerine chips offer a more interesting way to enjoy the flavors of Jeju tangerine. Most of the tangerine juice and tangerine chips sold in souvenir shops around Jeju are made from tangerine grown without pesticides and processed in a healthy way without additives.",
    sold: "100",
    stock: "69",
    price: "7.52",
    img: "https://i.ibb.co/tXtS5Kv/juice.png",
    discount: "50",
    rating: "4",
  ),
  Item(
    id: "item014",
    name: "Ramyeon",
    category: "food",
    seller: "By Jeju",
    origin:
        "Jeju Ramyeon is a flavorful and hearty instant noodle dish that captures the essence of Jeju Island's culinary traditions. Made with high-quality ingredients, it often incorporates locally sourced produce such as Jeju-grown seaweed, mushrooms, or seafood, adding a distinct taste that reflects the island’s fresh, coastal flavors. The broth is typically rich and savory, infused with a combination of spices and natural ingredients that offer a balance of heat and umami.",
    description:
        "Surprisingly, this ramyeon is made with black pork. The broth captures the deep flavors of black pork, in which plump and chewy noodles swim as vehicles of that flavor. Don’t forget to add some cold rice to the soup after finishing the ramyeon. Cold rice soaks up all the good stuff from the broth, and before long, you will be staring into the base of the bowl.",
    sold: "60",
    stock: "24",
    price: "7.52",
    img: "https://i.ibb.co/347Dnqf/ramyeon.png",
    discount: "10",
    rating: "4",
  ),
  Item(
    id: "item015",
    name: "Black Pork Jerky",
    category: "food",
    seller: "By Jeju",
    origin:
        "Black pork jerky is a worthy part of any gourmand trip in Jeju. It is sourced from Jeju black pigs grown with eco-friendly means, and the oak smoking process gives the jerky an excellent flavor and fragrance. What’s more, it is made according to traditional Korean methods, where the meat is first trimmed of fat, sliced thin, and spiced in soy sauce and other condiments.",
    description:
        "Black pork jerky is a worthy part of any gourmand trip in Jeju. It is sourced from Jeju black pigs grown with eco-friendly means, and the oak smoking process gives the jerky an excellent flavor and fragrance. What’s more, it is made according to traditional Korean methods, where the meat is first trimmed of fat, sliced thin, and spiced in soy sauce and other condiments.",
    sold: "50",
    stock: "43",
    price: "3.76",
    img: "https://i.ibb.co/WcgvkjJ/jerky.png",
    discount: "5",
    rating: "4",
  ),
  Item(
    id: "item016",
    name: "Hallasan Cookie",
    category: "food",
    seller: "By Jeju",
    origin:
        "Slowly dried to preserve its savory richness, Jeju Black Pork Jerky has a perfect balance of smoky, salty, and slightly sweet flavors with a satisfying chewy texture. Its unique taste reflects the island’s culinary heritage, offering a gourmet snack that is both nutritious and delicious. High in protein and low in fat, it’s a perfect on-the-go snack or a special treat to enjoy with drinks.",
    description:
        "This cookie is made in the shape of the Hallasan Mountain, as seen from Seogwipo. It comes in four flavors, made with good ingredients like Udo Island’s peanuts, Hallabong, and Jeju matcha. Its resemblance to Hallasan Mountain makes it all the more delicious.",
    sold: "90",
    stock: "83",
    price: "11.27",
    img: "https://i.ibb.co/n1zxvDd/cookie.png",
    discount: "5",
    rating: "4",
  ),
  Item(
    id: "item017",
    name: "Hallsan Cream Bun",
    category: "food",
    seller: "Halladang",
    origin:
        "Inspired by the natural beauty of Jeju’s iconic mountain, the Hallasan Cream Bun offers a sweet and satisfying taste of the island’s culinary creativity, making it a must-try for locals and visitors alike.",
    description:
        "This bread looks like the Hallasan Mountain with a snow-capped peak. Its sumptuous appearance is positively inviting. There is quite a variety of flavors, from milk cream to vanilla, Udo Island’s peanuts, and organic matcha, so you have plenty of variety to choose from.",
    sold: "20",
    stock: "12",
    price: "11.27",
    img: "https://i.ibb.co/J3RQBFH/cream.png",
    discount: "5",
    rating: "4",
  ),
  Item(
    id: "item018",
    name: "Hallabong Tea",
    category: "food",
    seller: "JEJU 4MOON",
    origin:
        "The tea is often made by drying the peels or infusing the juice of fresh Hallabong oranges, creating a drink that is not only flavorful but also packed with vitamins and antioxidants. When steeped, the tea releases a refreshing citrus aroma that instantly transports you to Jeju’s sunny orchards. Some versions of Hallabong Tea also include bits of the fruit or honey, enhancing the natural sweetness and adding a rich, smooth finish",
    description:
        "This product blends Hallabong fruits, which have been grown in Jeju’s pristine nature, with honey and other ingredients for both taste and health benefits. The flavor is sweet and tangy, while its rich vitamin content helps mitigate fatigue and prevent colds.",
    sold: "70",
    stock: "63",
    price: "5.26",
    img: "https://i.ibb.co/1MTpXHg/tea.png",
    discount: "10",
    rating: "4",
  ),
  Item(
    id: "item019",
    name: "Gosori and Omegi Liquor",
    category: "food",
    seller: "Jeju Saemju",
    origin:
        "Gosori Liquor is a distilled beverage made from local grains, typically barley or millet, with the key ingredient being water filtered through Jeju’s volcanic rock. The word Gosori refers to the pot still used in the distillation process, a traditional method that dates back centuries. The liquor captures the purity of Jeju’s pristine environment, with hints of earthy minerals, making it smooth yet complex. Locals believe that the volcanic rock water infuses the liquor with a distinct taste, one that represents the island's raw, natural beauty. It’s said that the technique has been passed down through generations of Jeju’s rural communities, making Gosori a drink that connects modern-day islanders with their ancestors.",
    description:
        "Gosori Liquor is a distilled liquor made with millet grown in Jeju. This historic liquor is fruity, goes down smoothly, and gives way to deep flavors. Omegi Liquor, fermented from omegi (millet) rice cake, also impresses with its deep flavors.",
    sold: "80",
    stock: "75",
    price: "15.03",
    img: "https://i.ibb.co/jyyGqZ1/gosori.png",
    discount: "5",
    rating: "4",
  ),
  Item(
    id: "item020",
    name: "Camellia Liquor",
    category: "food",
    seller: "Wangjike Brewery",
    origin:
        "What makes Camellia Liquor special is not only its delicate taste but its deep cultural roots. On Jeju Island, Camellia flowers have been used for centuries in traditional medicine, known for their health benefits, including boosting energy and promoting skin health. This liquor, made in small batches by local artisans, honors that tradition by capturing the spirit of the island’s natural beauty and the craftsmanship of its people. Often served as an aperitif or enjoyed with traditional Jeju dishes, Camellia Liquor is a luxurious and rare taste of Jeju’s botanical richness.",
    description:
        "This liquor is fermented with red petals of camellia flowers in Jeju. It is fragrant with floral notes, tangy, and soft, with a beautiful, natural color.",
    sold: "100",
    stock: "63",
    price: "7.52",
    img: "https://i.ibb.co/mNwfr2X/camellia.png",
    discount: "5",
    rating: "4",
  ),
];
