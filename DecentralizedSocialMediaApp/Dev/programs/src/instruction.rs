pub enum Instruction {
    // Define the different kinds of instructions your program will accept
    ActionOne {
        // parameters for this action
    },
    // ... other actions
}

impl Instruction {
    pub fn unpack(input: &[u8]) -> Result<Self, ProgramError> {
        // Logic to deserialize the instruction
    }
}
