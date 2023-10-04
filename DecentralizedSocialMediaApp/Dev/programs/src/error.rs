use thiserror::Error;

#[derive(Error, Debug, Clone, Copy)]
pub enum SocialMediaError {
    #[error("Invalid Instruction")]
    InvalidInstruction,

    #[error("Missing Required Signature")]
    MissingRequiredSignature,

    #[error("Post Content Exceeds Limit")]
    PostContentExceedsLimit,

    #[error("Incorrect Account Owner")]
    IncorrectAccountOwner,

    //! ... More custom errors as needed
}

impl From<SocialMediaError> for i32 {
    fn from(e: SocialMediaError) -> i32 {
        match e {
            SocialMediaError::InvalidInstruction => 1,
            SocialMediaError::MissingRequiredSignature => 2,
            SocialMediaError::PostContentExceedsLimit => 3,
            SocialMediaError::IncorrectAccountOwner => 4,
            //! ... Match other custom errors as added
        }
    }
}
