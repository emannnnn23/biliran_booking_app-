class ProviderBookingOrder {
  final String providerEmail;
  final String clientName;
  final String serviceName;
  final String date;
  final String status;

  ProviderBookingOrder({
    required this.providerEmail,
    required this.clientName,
    required this.serviceName,
    required this.date,
    required this.status,
  });
}

List<ProviderBookingOrder> mockProviderBookingOrders = [

  ProviderBookingOrder(
    providerEmail: "catering@gmail.com",
    clientName: "Ana Santos",
    serviceName: "Full Catering Service",
    date: "Dec 12, 2025",
    status: "Pending",
  ),
  ProviderBookingOrder(
    providerEmail: "catering@gmail.com",
    clientName: "Maria Lopez",
    serviceName: "Buffet Package",
    date: "Dec 20, 2025",
    status: "Approved",
  ),
  ProviderBookingOrder(
    providerEmail: "photo@gmail.com",
    clientName: "Carlos Gomez",
    serviceName: "Photo Coverage",
    date: "Jan 05, 2026",
    status: "Completed",
  ),
];