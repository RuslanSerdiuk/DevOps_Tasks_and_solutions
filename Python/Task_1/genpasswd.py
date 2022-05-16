import argparse
import random
import string
import re
import logging

logger = logging.getLogger(__name__)


def add_argument() -> object:
    """
    :return: CLI arguments that can be passed
    """
    parser = argparse.ArgumentParser(fromfile_prefix_chars='@')
    # Optional CLI args
    parser.add_argument('-l', '--length', action='store', type=int, help='length of password', default=10, metavar='', choices=range(1, 1000))
    parser.add_argument('-t', '--template', action='store', type=str, help='template of password',
                        default='[A%a%d%p%-%@%]', metavar='')
    parser.add_argument('-f', '--file', metavar='')
    parser.add_argument('-c', '--count', action='store', type=int, help='number of passwords to generate', default=1,
                        metavar='')
    parser.add_argument('-v', '--verbose', help='verbose mode', action='store_const', const=True, metavar='-v')
    args = parser.parse_args()
    return args


class GenPasswd:
    def __init__(self, template: object):
        """
        Generate password using template
        :param template:
        """
        self.token = None
        self.token_type = None
        self.count = None
        self.template = template
        self.passwd = ''
        self.passwd_chunk = ''
        self.set_passwd_chunk = ''
        self.check_template()

    def gen_passwd(self) -> object:
        """
        Generate a part of the code for one token
        :return:
        """
        self.passwd_chunk = ''  # Clean part of passwd from the previous token
        self.count = int(self.count)
        if self.token_type == 'A':
            self.passwd_chunk += ''.join(random.choices(string.ascii_uppercase, k=self.count))
        elif self.token_type == 'a':
            self.passwd_chunk += ''.join(random.choices(string.ascii_lowercase, k=self.count))
        elif self.token_type == 'd':
            self.passwd_chunk += ''.join(random.choices(string.digits, k=self.count))
        elif self.token_type == 'p':
            self.passwd_chunk += ''.join(random.choices(string.punctuation, k=self.count))
        elif self.token_type == '-':
            self.passwd_chunk += '-'
        elif self.token_type == '@':
            self.passwd_chunk += '@'
        return self.passwd_chunk

    def parse_template(self) -> object:
        """
        Get token type e.g. A, p, d and the number characters for it
        :rtype: object
        """
        self.token_type = self.token[0]
        if len(self.token) > 1 and re.findall('\d+', self.token):
            self.count = self.token[1:]
        else:
            self.count = 1

    def mix_up(self) -> str:
        """
        Mix up all generated sequence for set - []
        self.count = 3, len of mixed string will be 3
        :return: mixed set string
        """
        return ''.join(random.sample(self.set_passwd_chunk, len(self.set_passwd_chunk)))[:self.count]

    def check_template(self) -> object:
        """
        On each iteration we grab first token, process it,
        and then cut it off from template until the end
        :return: password
        """
        logger.info('Starting password generating process...')
        logger.info('Cutting tokens')
        while self.template:
            logger.info(f'Tokens: {self.template}')
            # If we have set in the template at the first position
            if '[' in self.template[0]:
                token_data = re.findall('\[(.*?)\](\d+)%*', self.template)[0]
                # Get tokens and set length
                tokens, self.count = token_data[0], token_data[-1]
                # Gen symbols for every token
                for token_type in tokens.split('%'):
                    self.token_type = token_type
                    self.set_passwd_chunk += self.gen_passwd()

                self.passwd += self.mix_up()
                self.template = ''.join(re.split(token_data[0] + r'\]\d+%*', self.template))[1:]

            else:
                # If it is not last token gen part of password and split it from template
                if '%' in self.template:
                    self.token = self.template.split('%')[0]
                    self.parse_template()
                    self.passwd += self.gen_passwd()

                    self.template = self.template[self.template.index("%") + 1:]  # Grab all until first %
                # In case of last token, stop
                else:
                    self.token = self.template
                    self.parse_template()
                    self.passwd += self.gen_passwd()
                    # Stop iterating
                    self.template = False
        return self.passwd


def main(args: object) -> object:
    """
    :param args: CLI arguments
    :return: Generated password
    """
    if args.verbose:
        logging.basicConfig(
            filename='log.log',
            filemode='a',
            level=logging.INFO,
            format='%(asctime)s.%(msecs)03d - %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S',
        )
    else:
        logging.basicConfig(
            level=logging.WARNING,
            format='%(asctime)s - %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S',
        )

    if args.file:
        # Read templates from file
        try:
            with open(args.file, "r") as file:
                lines = file.readlines()
                for line in lines:
                    template = line.strip()
                    passwd = GenPasswd(template).passwd
                    print(passwd)
        except FileNotFoundError:
            print('Please enter correct filename')

    else:
        # Generate number of passwords that is in the args.count, with length that is in args.length
        for i in range(args.count):
            if args.template:
                if args.template[-1] == '%' or args.template[-2] == '%':
                    template = args.template + str(args.length)
                    passwd = GenPasswd(template).passwd
                    print(passwd)
                else:
                    print('Please enter correct template')


if __name__ == '__main__':
    main(add_argument())
