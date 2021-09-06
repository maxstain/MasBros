import 'package:firebase_database/firebase_database.dart';
import 'package:masbros/Resources/Date.dart';
import 'package:masbros/Services/Appointments_Services.dart';

final List<DataSnapshot?> dates = AppointmentsService().GetAppointment();
