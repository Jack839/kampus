class Category {
  String title;
  String serviceStatus;
  double rating;
  String imagePath;

  Category({
    this.title = '',
    this.imagePath = '',
    this.serviceStatus = '',
    this.rating = 0.0,
  });

  static List<Category> appMenuList = [
    Category(
      imagePath: 'assets/images/live_bus_tracking.png',
      title: 'Live Bus Tracking',
      serviceStatus: 'Online',
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/images/online_food_order.png',
      title: 'Order Food',
      serviceStatus: 'Online',
      rating: 4.9,
    ),
    Category(
      imagePath: 'assets/images/complaint_portal.png',
      title: 'Complaint Portal',
      serviceStatus: 'Online',
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/images/semester_schedule.png',
      title: 'Semester Schedule',
      serviceStatus: 'Online',
      rating: 4.9,
    ),
  ];
}
