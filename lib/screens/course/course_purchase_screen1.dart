import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/widgets/elements/spinner.dart';

class CourseShippingScreen extends StatefulWidget {
  const CourseShippingScreen({super.key});

  @override
  State<CourseShippingScreen> createState() => _CourseShippingScreenState();
}

class _CourseShippingScreenState extends State<CourseShippingScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('خرید دوره', style: TextStyle(color: Colors.black, fontSize: 15)),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_right, color: Colors.black, size: 22),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    height: deviceSize.height * 0.25,
                    width: deviceSize.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 15, right: 8),
                                  width: 150,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      'https://bs-uploads.toptal.io/blackfish-uploads/components/seo/content/og_image_file/og_image/1275958/top-18-most-common-angularjs-developer-mistakes-41f9ad303a51db70e4a5204e101e7414.png',
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) => Image.asset(
                                        'assets/images/placeholder.png',
                                        fit: BoxFit.cover,
                                      ),
                                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return const Center(
                                          child: Spinner(
                                            size: 25,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 7, top: 22),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'دوره آموزش برنامه نویسی انگولار',
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: false,
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Text('تعداد جلسات : ', style: TextStyle(fontSize: 12)),
                                          Text('454', style: TextStyle(fontSize: 13, color: Colors.blue)),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [Text('مدت دوره : ', style: TextStyle(fontSize: 12)), Text('45464', style: TextStyle(fontSize: 13, color: Colors.red))],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Text('درصد تخفیف : ', style: TextStyle(fontSize: 15)),
                                      Text('65', style: TextStyle(fontSize: 15, color: Colors.green)),
                                    ],
                                  ),
                                  Row(
                                    children: [Text('قیمت نهایی : '), Text('45455', style: TextStyle(fontSize: 15, color: Colors.blue)), Text(' تومان', style: TextStyle(fontSize: 17, color: Colors.blue))],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  height: deviceSize.height * 0.65,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green[400],
                          child: const Image(
                            width: 24,
                            height: 24,
                            color: Colors.white,
                            image: AssetImage('assets/images/icons/free.png'),
                          ),
                        ),
                        onTap: () {},
                        title: const Text(
                          'رایگان',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ListTile(
                        leading: const CircleAvatar(
                          child: Image(
                            width: 24,
                            height: 24,
                            image: AssetImage('assets/images/icons/person.png'),
                          ),
                        ),
                        onTap: () {},
                        title: const Text(
                          'پرداخت توسط فراگیر',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text(
                          'درگاه پرداخت',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ListTile(
                        leading: const CircleAvatar(
                          child: Image(
                            width: 22,
                            height: 22,
                            image: AssetImage('assets/images/icons/document.png'),
                          ),
                        ),
                        onTap: () {},
                        title: const Text(
                          'پرداخت توسط فراگیر',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text(
                          'سند بانکی',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Image(
                            width: 25,
                            height: 25,
                            image: AssetImage('assets/images/icons/office.png'),
                          ),
                        ),
                        onTap: () {},
                        title: const Text(
                          'پرداخت توسط دستگاه اجرایی',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
