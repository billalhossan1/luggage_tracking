import 'package:flutter/material.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class WorkFuncScreen extends StatelessWidget {
  const WorkFuncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Work Functionality"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AppText(
                textAlign: TextAlign.center,
                data: """Function 1:
        At Westfert, we value your trust and are committed to protecting your personal information. This Privacy Policy outlines how we collect, use, and safeguard your data when you use our app and services.
        
        Function 2:
        a. Personal Information
        When you sign up for Westfert, we may collect personal details such as:
        Your name
        Email address
        Phone number
        Payment information (securely processed via Square or a similar service)
        Location data (to match you with nearby barbers)
        
        
        Function 3:
        b. Non-Personal Information
        We may also collect non-identifiable data like:
        Device type and operating system
        App usage data (e.g., features you interact with)
        IP address
        
        
        2. How We Use Your Information
        We use your information to:
        
        Provide and improve our services
        Match you with barbers based on your location and preferences
        Process secure payments
        Send notifications about bookings, updates, or promotions
        Improve user experience through analytics
        3. Sharing Your Information
        We respect your privacy and only share your data in limited circumstances:
        With barbers: To facilitate bookings, your name and appointment details are shared with the selected barber.
        With payment processors: Payment information is securely handled by trusted third-party providers like Square.
        For legal reasons: If required by law or to protect the rights of BarberMe and its users.
        We do not sell your personal information to third parties.
        4. Data Security
        We take the security of your information seriously. We use encryption, secure servers, and regular monitoring to protect your data from unauthorized access. However, no method of transmission over the internet is 100% secure, so we encourage you to take precautions when sharing sensitive information.
        
        
        
        
        5. Your Choices
        Updating Your Information: You can update your profile information through the app at any time.
        Location Sharing: You can disable location services in your device settings, but this may limit certain app features.
        Marketing Communications: Opt-out of promotional emails by clicking “unsubscribe” at the bottom of the email.
        6. Third-Party Links
        BarberMe may include links to third-party websites or services. We are not responsible for the privacy practices of those third parties. We recommend reviewing their policies before sharing any personal information.
        7. Children’s Privacy
        BarberMe is not intended for children under 13. We do not knowingly collect information from children. If we become aware of such data, we will take steps to delete it immediately.
        8. Changes to This Privacy Policy
        We may update this Privacy Policy from time to time. Any changes will be posted here with the updated effective date. We encourage you to review this page regularly.
        9. Contact Us
        If you have any questions about this Privacy Policy or how we handle your data, please contact us:
        Email: privacy@barberme.com""",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
