# RpnUIA

A simple Reverse Polish Notation converter and calculator

## Installation

Download the repository:

    $ git clone https://github.com/yuki07yuki/rpn_uia.git

cd into the directory:

    $ cd rpn_uia

And then execute:

    $ bundle install

## Usage

Run either infix to postfix converter

    $ bin/infix_to_postfix 

or postfix calculator

    $ bin/postfix_calculator

As the name suggests infix_to_postfix converts the infix expression to postfix
expression while postfix_calculator calculates the postfix expression and helps
visualize the steps.

Note:  
Either of the executables do not check the correctness of the expression. These
merely helps to visualize the steps taken to either convert to postfix
expression or calculate the postfix expression.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
