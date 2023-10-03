use thiserror::Error;

#[derive(Error, Debug, Copy, Clone)]
pub enum SocialMediaError {
    #[error("Invalid Instruction")]
    InvalidInstruction,
    // ... other custom errors
}

impl From<SocialMediaError> for ProgramError {
    fn from(e: SocialMediaError) -> Self {
        ProgramError::Custom(e as u32)
    }
}

// You can add more specific errors as needed
