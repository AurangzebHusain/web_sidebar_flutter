import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  int? selectedIndex;
  NavIconModel? selectedModel;
  int? hoveredIndex;
  NavIconModel? hoveredModel;
  List<NavIconModel> navIcons = [
    NavIconModel(name: "Home", tooltipMessage: "ABC Menu", icon: Icons.home),
    NavIconModel(name: "Shop", icon: Icons.shopping_bag_rounded),
    NavIconModel(name: "Orders", tooltipMessage: "Orders Menu", icon: Icons.shopping_bag),
    NavIconModel(name: "WishList", tooltipMessage: "Wishlist Page", icon: Icons.shopping_cart),
    NavIconModel(name: "My Account", tooltipMessage: "My Accounts Page", icon: Icons.person_outline_rounded),
    NavIconModel(name: "Home", tooltipMessage: "Home Menu", icon: Icons.home),
    NavIconModel(name: "Shop", tooltipMessage: "Shop Menu", icon: Icons.shopping_bag_rounded),
    NavIconModel(name: "Orders", tooltipMessage: "Orders Menu", icon: Icons.shopping_bag),
    NavIconModel(name: "WishList", tooltipMessage: "Wishlist Page", icon: Icons.shopping_cart),
    NavIconModel(name: "My Account", tooltipMessage: "My Accounts Page", icon: Icons.person_outline_rounded),
    NavIconModel(name: "Home", tooltipMessage: "Home Menu", icon: Icons.home),
    NavIconModel(name: "Shop", tooltipMessage: "Shop Menu", icon: Icons.shopping_bag_rounded),
    NavIconModel(name: "Orders", tooltipMessage: "Orders Menu", icon: Icons.shopping_bag),
    NavIconModel(name: "WishList", tooltipMessage: "Wishlist Page", icon: Icons.shopping_cart),
    // NavIconModel(name: "My Account", tooltipMessage: "My Accounts Page", icon: Icons.person_outline_rounded),
    // NavIconModel(name: "Home", tooltipMessage: "Home Menu", icon: Icons.home),
    // NavIconModel(name: "Shop", tooltipMessage: "Shop Menu", icon: Icons.shopping_bag_rounded),
    // NavIconModel(name: "Orders", tooltipMessage: "Orders Menu", icon: Icons.shopping_bag),
    // NavIconModel(name: "WishList", tooltipMessage: "Wishlist Page", icon: Icons.shopping_cart),
    // NavIconModel(name: "My Account", tooltipMessage: "My Accounts Page", icon: Icons.person_outline_rounded),
    // NavIconModel(name: "WishList", tooltipMessage: "Wishlist Page", icon: Icons.shopping_cart),
    // NavIconModel(name: "My Account", tooltipMessage: "My Accounts Page", icon: Icons.person_outline_rounded),
    // NavIconModel(name: "Home", tooltipMessage: "Home Menu", icon: Icons.home),
    // NavIconModel(name: "Shop", tooltipMessage: "Shop Menu", icon: Icons.shopping_bag_rounded),
    // NavIconModel(name: "Orders", tooltipMessage: "Orders Menu", icon: Icons.shopping_bag),
    // NavIconModel(name: "WishList", tooltipMessage: "Wishlist Page", icon: Icons.shopping_cart),
    // NavIconModel(name: "My Account", tooltipMessage: "My Accounts Page", icon: Icons.person_outline_rounded)
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Sidebar(
        showToolTip: true,
        // animatedContainerDecoration: (selectedNavItem, si) {
        //   return BoxDecoration(color: selectedIndex == si ? Colors.red : null);
        // },
        // navItemPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        onTap: (sitem, sindex) {
          selectedIndex = sindex;
          selectedModel = sitem;
        },
        onHover: (hoveredIndex) {
          hoveredIndex = hoveredIndex;
        },

        items: navIcons,

        minimizedSidebarWidth: 40,
        body: (sitem, sindex) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Text(
                  sitem?.name ?? "",
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Sidebar extends StatefulWidget {
  double maximizedSidebarWidth = 150;
  double minimizedSidebarWidth = 80;
  bool showToolTip;
  double navItemGap;
  List<NavIconModel> items;
  double showOnlyMinimizedWidth;
  Widget Function(NavIconModel? selectedMenu, int? selectedIndex) body;
  Duration animatedContainerDuration = Duration(milliseconds: 50);
  EdgeInsets navItemPadding;
  EdgeInsets animatedContainerPadding;
  bool isMaximized;
  // int? hoveredIndex;
  Color? navBarBackgroundColor;

  // BoxDecoration? animatedContainerDecoration;
  BoxDecoration Function(NavIconModel selectedItem, int selectedIndex)? animatedContainerDecoration;
  Widget? customCloseWidget;
  void Function()? onClosePressed;
  void Function(NavIconModel selectedItem, int selectedIndex)? onTap;
  void Function(int? hoveredIndex)? onHover;

  Sidebar({
    Key? key,
    required this.items,
    this.maximizedSidebarWidth = 150,
    this.minimizedSidebarWidth = 80,
    this.showToolTip = true,
    required this.body,
    this.isMaximized = false,
    this.navBarBackgroundColor = Colors.grey,
    this.animatedContainerDecoration,
    this.customCloseWidget,
    this.onClosePressed,
    this.showOnlyMinimizedWidth = 275,
    this.onTap,
    this.onHover,
    this.navItemGap = 20,
    this.navItemPadding = const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    this.animatedContainerPadding = const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
  }) : super(key: key) {
    assert(minimizedSidebarWidth >= 10, "Minimized Sidebar width cannot be less than 10");
  }

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  NavIconModel? selectedItem;
  int? selectedIndex;
  int? hoveredIndex;
  late double _maximizedTotalWidth;
  late double _minimizedTotalWidth;
  double screenWidth = 0;
  setActive(int? index) {
    setState(() {
      hoveredIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setDeviceWidth();
    _maximizedTotalWidth = widget.maximizedSidebarWidth + (widget.navItemGap) + (widget.animatedContainerPadding.left + widget.animatedContainerPadding.right) + (widget.navItemPadding.right + widget.navItemPadding.left);
    _minimizedTotalWidth = widget.minimizedSidebarWidth + (widget.navItemGap) + (widget.animatedContainerPadding.left + widget.animatedContainerPadding.right) + (widget.navItemPadding.right + widget.navItemPadding.left);
  }

  @override
  void didUpdateWidget(Sidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  setDeviceWidth() {
    print("Set device width");
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < widget.showOnlyMinimizedWidth) {
      print("setting device width");
      widget.isMaximized = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    setDeviceWidth();
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: screenWidth < 576
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(height: MediaQuery.of(context).size.height - (_minimizedTotalWidth), child: widget.body(selectedItem, selectedIndex)),
                  Flexible(
                    child: AnimatedContainer(
                      duration: widget.animatedContainerDuration,
                      color: widget.navBarBackgroundColor,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ...widget.items.mapIndexed((index, navItem) => Flexible(
                                  child: InkWell(
                                      onHover: (bool val) {
                                        if (val) {
                                          setActive(index);
                                        } else {
                                          setActive(null);
                                        }
                                        if (widget.onHover != null) {
                                          widget.onHover!(hoveredIndex);
                                        }
                                      },
                                      onTap: () {
                                        if (widget.onTap != null) {
                                          widget.onTap!(navItem, index);
                                        }
                                        setState(() {
                                          selectedItem = navItem;
                                          selectedIndex = index;
                                        });
                                      },
                                      child: (widget.showToolTip)
                                          ? Tooltip(
                                              preferBelow: false,
                                              enableFeedback: true,
                                              showDuration: const Duration(milliseconds: 20),
                                              message: navItem.tooltipMessage ?? navItem.name,
                                              verticalOffset: 10,
                                              child: AnimatedContainer(
                                                duration: widget.animatedContainerDuration,
                                                padding: widget.navItemPadding,
                                                child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                  Icon(
                                                    navItem.icon,
                                                  ),
                                                  SizedBox(
                                                    width: widget.navItemGap,
                                                  ),
                                                  Flexible(child: Text(navItem.name ?? ''))
                                                ]),
                                              ),
                                            )
                                          : AnimatedContainer(
                                              duration: widget.animatedContainerDuration,
                                              padding: widget.navItemPadding,
                                              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                Icon(
                                                  navItem.icon,
                                                ),
                                                SizedBox(
                                                  width: widget.navItemGap,
                                                ),
                                                Flexible(child: Text(navItem.name ?? ''))
                                              ]),
                                            )),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: AnimatedContainer(
                      padding: widget.animatedContainerPadding,
                      duration: widget.animatedContainerDuration,
                      height: MediaQuery.of(context).size.height,
                      width: widget.isMaximized ? _maximizedTotalWidth : _minimizedTotalWidth,
                      color: widget.navBarBackgroundColor,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            backButton(),
                            IntrinsicWidth(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...widget.items.mapIndexed((index, navItem) => Flexible(
                                        child: InkWell(
                                            onHover: (bool val) {
                                              if (val) {
                                                setActive(index);
                                              } else {
                                                setActive(null);
                                              }
                                              if (widget.onHover != null) {
                                                widget.onHover!(hoveredIndex);
                                              }
                                            },
                                            onTap: () {
                                              if (widget.onTap != null) {
                                                widget.onTap!(navItem, index);
                                              }
                                              setState(() {
                                                selectedItem = navItem;
                                                selectedIndex = index;
                                              });
                                            },
                                            child: widget.isMaximized
                                                ? AnimatedContainer(
                                                    duration: widget.animatedContainerDuration,
                                                    decoration: widget.animatedContainerDecoration != null ? widget.animatedContainerDecoration!(navItem, index) : BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: index == hoveredIndex ? Colors.grey[300] : null),
                                                    padding: widget.navItemPadding,
                                                    child: Row(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                                                      Icon(
                                                        navItem.icon,
                                                      ),
                                                      SizedBox(
                                                        width: widget.navItemGap,
                                                      ),
                                                      if (widget.isMaximized) Flexible(child: Text(navItem.name ?? ''))
                                                    ]),
                                                  )
                                                : (!widget.isMaximized && widget.showToolTip)
                                                    ? Tooltip(
                                                        preferBelow: false,
                                                        enableFeedback: true,
                                                        showDuration: const Duration(milliseconds: 20),
                                                        message: navItem.tooltipMessage ?? navItem.name,
                                                        verticalOffset: 10,
                                                        child: AnimatedContainer(
                                                          duration: widget.animatedContainerDuration,
                                                          padding: widget.navItemPadding,
                                                          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                            Icon(
                                                              navItem.icon,
                                                            ),
                                                          ]),
                                                        ),
                                                      )
                                                    : AnimatedContainer(
                                                        duration: widget.animatedContainerDuration,
                                                        padding: widget.navItemPadding,
                                                        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                          Icon(
                                                            navItem.icon,
                                                          ),
                                                        ]),
                                                      )),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(width: MediaQuery.of(context).size.width - (widget.isMaximized ? _maximizedTotalWidth : _minimizedTotalWidth), child: widget.body(selectedItem, selectedIndex))
                ],
              ),
      );
    });
  }

  Widget backButton() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        widget.customCloseWidget ??
            IconButton(
                splashRadius: 10,
                onPressed: widget.onClosePressed != null
                    ? () {
                        widget.onClosePressed!();
                        setState(() {
                          widget.isMaximized = !widget.isMaximized;
                        });
                      }
                    : () {
                        setState(() {
                          widget.isMaximized = !widget.isMaximized;
                        });
                      },
                icon: Icon(!widget.isMaximized ? Icons.arrow_forward_ios_outlined : Icons.arrow_back_ios_new)),
      ],
    );
  }
}

class NavIconModel {
  String name;

  ///By default name will be used for tooltip message if tooltipMessage not provided;
  String? tooltipMessage;
  String? iconImg;
  IconData? icon;
  NavIconModel({
    required this.name,
    this.tooltipMessage,
    this.iconImg,
    this.icon,
  });

  NavIconModel copyWith({
    String? name,
    String? tooltipMessage,
    String? iconImg,
    IconData? icon,
  }) {
    return NavIconModel(
      name: name ?? this.name,
      tooltipMessage: tooltipMessage ?? this.tooltipMessage,
      iconImg: iconImg ?? this.iconImg,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    if (tooltipMessage != null) {
      result.addAll({'tooltipMessage': tooltipMessage});
    }
    if (iconImg != null) {
      result.addAll({'iconImg': iconImg});
    }
    if (icon != null) {
      result.addAll({'icon': icon!.codePoint});
    }

    return result;
  }

  factory NavIconModel.fromMap(Map<String, dynamic> map) {
    return NavIconModel(
      name: map['name'] ?? '',
      tooltipMessage: map['tooltipMessage'],
      iconImg: map['iconImg'],
      icon: map['icon'] != null ? IconData(map['icon'], fontFamily: 'MaterialIcons') : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NavIconModel.fromJson(String source) => NavIconModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NavIconModel(name: $name, tooltipMessage: $tooltipMessage, iconImg: $iconImg, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NavIconModel && other.name == name && other.tooltipMessage == tooltipMessage && other.iconImg == iconImg && other.icon == icon;
  }

  @override
  int get hashCode {
    return name.hashCode ^ tooltipMessage.hashCode ^ iconImg.hashCode ^ icon.hashCode;
  }
}
