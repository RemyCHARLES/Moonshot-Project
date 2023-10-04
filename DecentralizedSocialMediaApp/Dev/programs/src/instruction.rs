use solana_program::program_error::ProgramError;
use std::mem::size_of;
use std::convert::TryInto;

pub enum SocialMediaInstruction {
    /// Creates a new post with the provided content.
    /// 
    /// Accounts expected by this instruction:
    /// 
    /// 0. `[signer]` The account of the user posting.
    /// 1. `[]` The post account, should be initialized and owned by the posting user.
    ///
    Post {
        /// The content of the post.
        content: Vec<u8>,
    },
    // TODO: add other instructions like Comment, Like, etc.
}

impl SocialMediaInstruction {
    /// Unpacks a byte buffer into a [SocialMediaInstruction](enum.SocialMediaInstruction.html).
    pub fn unpack(input: &[u8]) -> Result<Self, ProgramError> {
        let (tag, data) = input.split_at(1);
        match tag {
            &[0] => { 
                let content = data.to_vec();
                Ok(SocialMediaInstruction::Post { content })
            },
            // ... other instruction match arms as you add more instructions
            _ => Err(ProgramError::InvalidInstructionData),
        }
    }

    /// Packs a [SocialMediaInstruction](enum.SocialMediaInstruction.html) into a byte buffer.
    pub fn pack(&self) -> Vec<u8> {
        let mut buf = Vec::with_capacity(size_of::<Self>());
        match *self {
            SocialMediaInstruction::Post { ref content } => {
                buf.push(0);
                buf.extend_from_slice(&content);
            },
            // ... other instruction match arms as you add more instructions
        }
        buf
    }
}
