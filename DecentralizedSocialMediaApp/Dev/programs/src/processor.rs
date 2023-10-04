use solana_program::{
    account_info::AccountInfo,
    entrypoint::ProgramResult,
    pubkey::Pubkey,
    program_error::ProgramError,
    program_pack::Pack,
    msg,
};
use crate::state::Post; // Assuming you've defined a Post struct in state.rs

pub struct Processor;

impl Processor {
    /// Process a Post instruction
    pub fn process_post(
        accounts: &[AccountInfo],
        content: Vec<u8>
    ) -> ProgramResult {
        let account_info_iter = &mut accounts.iter();
        
        // Getting the user's account. This should be the account of the user posting.
        let user_account = next_account_info(account_info_iter)?;

        // Check if the user's account is the signer
        if !user_account.is_signer {
            return Err(ProgramError::MissingRequiredSignature);
        }

        // Getting the post account. This account should store the post details.
        let post_account = next_account_info(account_info_iter)?;

        // Unpack the Post account data
        let mut post_data = Post::unpack_unchecked(&post_account.data.borrow())?;

        // Update the post data
        post_data.content = content.try_into().or(Err(ProgramError::InvalidInstructionData))?;

        // Pack the updated post data back into the post account
        Post::pack(post_data, &mut post_account.data.borrow_mut())?;

        msg!("Posted successfully!");

        Ok(())
    }

    // TODO: add more processors here for other instructions like Comment, Like, etc.
}
