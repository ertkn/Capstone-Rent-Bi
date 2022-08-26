import 'package:capstone_rent_bi/screens/chatpages/talkpage.dart';
import 'package:capstone_rent_bi/services/chatdb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductPageView extends StatefulWidget {
  const ProductPageView({Key? key}) : super(key: key);

  @override
  State<ProductPageView> createState() => _ProductPageViewState();
}

class _ProductPageViewState extends State<ProductPageView> {
  String resimUrl =
      "https://www.apple.com/newsroom/images/product/mac/standard/Apple-MacBook-Pro-M2-13-availability-June-2022-hero.jpg.news_app_ed.jpg";
  String baslik = "Macbook Pro 2022";
  String aciklama =
      "Karşınızda bugüne kadarki en güçlü MacBook Pro var. Profesyoneller için tasarlanan ilk Apple çipler: ışık hızında M1 Pro veya M1 Max. Çığır açan bir performans. Muhteşem bir pil ömrü. Göz alıcı Liquid Retina XDR ekran. Mac dizüstü bilgisayarlardaki en iyi kamera ve ses teknolojisi. Ve ihtiyacınız olan tüm bağlantı noktaları. Türünün ilk örneği olan bu MacBook Pro, gerçek bir canavar.Karşınızda bugüne kadarki en güçlü MacBook Pro var. Profesyoneller için tasarlanan ilk Apple çipler: ışık hızında M1 Pro veya M1 Max. Çığır açan bir performans. Muhteşem bir pil ömrü. Göz alıcı Liquid Retina XDR ekran. Mac dizüstü bilgisayarlardaki en iyi kamera ve ses teknolojisi. Ve ihtiyacınız olan tüm bağlantı noktaları. Türünün ilk örneği olan bu MacBook Pro, gerçek bir canavar.Karşınızda bugüne kadarki en güçlü MacBook Pro var. Profesyoneller için tasarlanan ilk Apple çipler: ışık hızında M1 Pro veya M1 Max. Çığır açan bir performans. Muhteşem bir pil ömrü. Göz alıcı Liquid Retina XDR ekran. Mac dizüstü bilgisayarlardaki en iyi kamera ve ses teknolojisi. Ve ihtiyacınız olan tüm bağlantı noktaları. Türünün ilk örneği olan bu MacBook Pro, gerçek bir canavar.Karşınızda bugüne kadarki en güçlü MacBook Pro var. Profesyoneller için tasarlanan ilk Apple çipler: ışık hızında M1 Pro veya M1 Max. Çığır açan bir performans. Muhteşem bir pil ömrü. Göz alıcı Liquid Retina XDR ekran. Mac dizüstü bilgisayarlardaki en iyi kamera ve ses teknolojisi. Ve ihtiyacınız olan tüm bağlantı noktaları. Türünün ilk örneği olan bu MacBook Pro, gerçek bir canavar.Karşınızda bugüne kadarki en güçlü MacBook Pro var. Profesyoneller için tasarlanan ilk Apple çipler: ışık hızında M1 Pro veya M1 Max. Çığır açan bir performans. Muhteşem bir pil ömrü. Göz alıcı Liquid Retina XDR ekran. Mac dizüstü bilgisayarlardaki en iyi kamera ve ses teknolojisi. Ve ihtiyacınız olan tüm bağlantı noktaları. Türünün ilk örneği olan bu MacBook Pro, gerçek bir canavar.Karşınızda bugüne kadarki en güçlü MacBook Pro var. Profesyoneller için tasarlanan ilk Apple çipler: ışık hızında M1 Pro veya M1 Max. Çığır açan bir performans. Muhteşem bir pil ömrü. Göz alıcı Liquid Retina XDR ekran. Mac dizüstü bilgisayarlardaki en iyi kamera ve ses teknolojisi. Ve ihtiyacınız olan tüm bağlantı noktaları. Türünün ilk örneği olan bu MacBook Pro, gerçek bir canavar.";
  String adSoyad = "Darth Vader";
  String kullaniciAvatarUrl =
      'https://avatarfiles.alphacoders.com/286/thumb-286017.jpg';
  String kullaniciUid = "s1dOU5JP6tIeXN4Qe2ij";
  int fiyat = 10;

  Color highlightedColor = const Color(0xffF56A43);
  Color backgroundColor = const Color(0xff0E0B2A);
  Color textColor = Colors.grey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: sliver(),
    );
  }

  Widget sliver() {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * .4,
                floating: false,
                pinned: true,
                actions: [sendMessageButton()],
                iconTheme: IconThemeData(
                  color: highlightedColor, //change your color here
                ),
                backgroundColor: backgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  //titlePadding: EdgeInsets.all(20),
                  background: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16)),
                    child: Image.network(
                      resimUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        baslik,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            fontSize: 35),
                      ),
                      Text(
                        "\$ $fiyat",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            fontSize: 35),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: highlightedColor),
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              foregroundImage: NetworkImage(kullaniciAvatarUrl),
                            ),
                          ),
                          Text(
                            adSoyad,
                            style: TextStyle(color: textColor, fontSize: 20),
                          )
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16)),
                        child: Text(
                          aciklama,
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget sendMessageButton() {
    return GestureDetector(
      onTap: () {
        Addchatroom(username: kullaniciUid, uid: kullaniciUid, user: adSoyad)
            .addChatRoom()
            .then((value) {
          String chatroomid =
              value.toString().replaceAll("true", "").replaceAll("|", "");
          if (value.toString().contains("true") &&
              kullaniciUid != FirebaseAuth.instance.currentUser!.uid) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TalkPage(
                          chatRoomId: chatroomid,
                          uid: kullaniciUid,
                        )));
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: highlightedColor,
        ),
        child: const Center(
            child: Text(
          "Mesaj Gönder",
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
