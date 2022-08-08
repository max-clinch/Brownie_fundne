from cgi import print_arguments
from brownie import Fundme 
from scripts.useful_scripts import get_account 

def fund():
    fund_me = Fundme[-1]
    account =get_account()
    entrance_fee = fund_me.getEntranceFee()
    print_arguments(entrance_fee)
    print(f"The current entry fee is {entrance_fee}")
    print("Funding")
    fund_me.fund({"from": account, "value": entrance_fee})

def withdraw():
    fund_me = Fundme[-1]
    account = get_account()
    fund_me.withdraw({"from": account})
    
    
def main():
    fund()
    withdraw()

