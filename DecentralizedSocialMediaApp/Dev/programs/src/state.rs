use solana_program::program_pack::{Pack, Sealed};
use arrayref::{array_mut_ref, array_ref, array_refs, mut_array_refs};

pub struct Post {
    pub user: Pubkey,
    pub content: [u8; 280], // example for a tweet-sized post
    // ... other fields like timestamp, likes, etc.
}

impl Sealed for Post {}

impl Pack for Post {
    const LEN: usize = 32 + 280; // Pubkey size + content size

    fn pack_into_slice(&self, output: &mut [u8]) {
        // Logic to serialize Post into bytes
    }

    fn unpack_from_slice(input: &[u8]) -> Result<Self, ProgramError> {
        // Logic to deserialize bytes into Post
    }
}

// ... other structs for user profiles, comments, etc.
