import 'package:ubermove/domain/models/paymentMethod.dart';

import '../core/base_events.dart';

class PaymentMethodListEvent = ListPayload<PaymentMethod> with BaseEvent;
