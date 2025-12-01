#include <iostream>
#include <fastrtps/fastrtps_all.h>

int main() {
    // Create a participant
    eprosima::fastrtps::ParticipantAttributes participantAttrs;
    participantAttrs.rtps.builtin.domainId = 0;
    participantAttrs.rtps.setName("ParticipantName");

    eprosima::fastrtps::Participant* participant = eprosima::fastrtps::Domain::createParticipant(participantAttrs);

    if (participant == nullptr) {
        std::cout << "Error creating participant" << std::endl;
        return 1;
    }

    // Main loop
    std::cout << "Participant created. Press Enter to exit." << std::endl;
    std::cin.get();

    // Delete participant
    eprosima::fastrtps::Domain::removeParticipant(participant);

    return 0;
}