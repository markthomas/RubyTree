# hash_converter.rb - This file is part of the RubyTree package.
#
# = hash_converter.rb - Provides TreeNode creation from a nested hash.
#
# Author::  Mark Thomas (mark@thomaszone.com)
#
# Time-stamp: <2012-08-25 22:55:05 anupam>
#
# RubyTree Copyright (C) 2012 Anupam Sengupta <anupamsg@gmail.com>
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
# - Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# - Redistributions in binary form must reproduce the above copyright notice, this
#   list of conditions and the following disclaimer in the documentation and/or
#   other materials provided with the distribution.
#
# - Neither the name of the organization nor the names of its contributors may
#   be used to endorse or promote products derived from this software without
#   specific prior written permission.
#
#   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Provides utility methods to create a {Tree::TreeNode} from a nested hash
module Tree::Utils::HashConverter

  def self.included(base)
    base.extend(ClassMethods)
  end

  # Creates child nodes from each of the hash pairs.
  #
  # @author Mark Thomas (http://github.com/markthomas)
  # @since 0.8.3
  #
  # @param [Hash] hash The subtree(s) to add
  # @return [Tree::TreeNode] The TreeNode with subtrees added from the hash
  #
  # @see ClassMethods#from_hash
  def from_hash(hash)
    hash.each do |key,value|
      new_node = value.is_a?(Hash) ? Tree::TreeNode.new(key).from_hash(value) : Tree::TreeNode.new(key,value)
      self << new_node
    end

    return self
  end

  # ClassMethods for the {HashConverter} module.  Will become class methods in the +include+ target.
  module ClassMethods
    # Helper method to create a Tree::TreeNode instance from a nested hash.
    # The hash should have a single top-level entry to become the root node. If the hash contains
    # more than one key/value pair, only the first is used.
    #
    # @author Mark Thomas (http://github.com/markthomas)
    # @since 0.8.3
    #
    # @param [Hash] hash The hash to convert from.
    #
    # @return [Tree::TreeNode] The created tree.
    def from_hash(hash)
      Tree::TreeNode.new(hash.keys.first).from_hash(hash.values.first)
    end
  end
end
