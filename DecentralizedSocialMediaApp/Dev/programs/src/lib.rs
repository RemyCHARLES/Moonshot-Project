use solana_program::{
    account_info::{AccountInfo, next_account_info},
    entrypoint, 
    entrypoint::ProgramResult, 
    msg,
    program_error::ProgramError, 
    pubkey::Pubkey, 
    program::invoke,
    instruction::InstructionError,
};

use crate::instruction::SocialMediaInstruction; // Assuming your instructions are named this way
use crate::processor; // Importing the processor functions

entrypoint!(process_instruction);

/// Entry point for the program
/// This function decodes the instruction_data and dispatches to the appropriate processing function
fn process_instruction(
    program_id: &Pubkey,
    accounts: &[AccountInfo],
    instruction_data: &[u8],
) -> ProgramResult {
    let instruction = SocialMediaInstruction::unpack(instruction_data)?;

    match instruction {
        SocialMediaInstruction::Post { content } => {
            msg!("Instruction: Post");
            processor::process_post(accounts, content)
        },
        // Add other instruction match arms as needed
    }
}

