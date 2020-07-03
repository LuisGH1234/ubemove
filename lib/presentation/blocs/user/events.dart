import 'package:ubermove/domain/models/company.dart';
import 'package:ubermove/domain/models/job.dart';
import 'package:ubermove/domain/models/paymentMethod.dart';

import '../core/base_events.dart';

class PaymentMethodListEvent = ListPayload<PaymentMethod> with BaseEvent;
class CompanyListEvent = ListPayload<Company> with BaseEvent;
class JobListEvent = ListPayload<Job> with BaseEvent;
class CreateJobEvent = Process with BaseEvent;
