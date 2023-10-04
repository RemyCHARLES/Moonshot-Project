use solana_program::{
    program_error::ProgramError,
    program_pack::{Pack, Sealed},
};
use arrayref::{array_mut_ref, array_ref, array_refs};

pub const POST_CONTENT_SPACE: usize = 280; // For instance, a max of 280 bytes 

pub struct Post {
    pub content: [u8; POST_CONTENT_SPACE],
    // TODO: add other fields like timestamp, post ID, etc.
}

impl Sealed for Post {}

impl Pack for Post {
    const LEN: usize = POST_CONTENT_SPACE; // Adjust if more fields are added

    fn unpack_from_slice(src: &[u8]) -> Result<Self, ProgramError> {
        let src = array_ref![src, 0, POST_CONTENT_SPACE];

        Ok(Post {
            content: *src,
            // Unpack other fields as they are added
        })
    }

    fn pack_into_slice(&self, dst: &mut [u8]) {
        let dst = array_mut_ref![dst, 0, POST_CONTENT_SPACE];
        let dst_content = dst;

        *dst_content = self.content;
        // Pack other fields as they are added
    }
}
