import React from 'react';
import PropTypes from 'prop-types';
import './Post.css'; 

const Post = ({ content, author, timestamp }) => (
  <div className="post">
    <div className="post-header">
      <span className="post-author">{author}</span>
      <span className="post-timestamp">{new Date(timestamp).toLocaleString()}</span>
    </div>
    <div className="post-content">
      {content}
    </div>
  </div>
);

Post.propTypes = {
  content: PropTypes.string.isRequired,
  author: PropTypes.string.isRequired,
  timestamp: PropTypes.number.isRequired,
};

export default Post;
