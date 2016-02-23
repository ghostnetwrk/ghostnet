// Copyright 2014 The go-ethereum Authors
// This file is part of the go-ethereum library.
//
// The go-ethereum library is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// The go-ethereum library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with the go-ethereum library. If not, see <http://www.gnu.org/licenses/>.

package common

import (
	"fmt"
	"math/big"
)

type StorageSize float64

func (self StorageSize) String() string {
	if self > 1000000 {
		return fmt.Sprintf("%.2f mB", self/1000000)
	} else if self > 1000 {
		return fmt.Sprintf("%.2f kB", self/1000)
	} else {
		return fmt.Sprintf("%.2f B", self)
	}
}

func (self StorageSize) Int64() int64 {
	return int64(self)
}

// The different number of units
var (
    Xgnt  = BigPow(10, 42)
    Zgnt  = BigPow(10, 21)
    Egnt  = BigPow(10, 18)
    Pgnt  = BigPow(10, 15)
    Tgnt  = BigPow(10, 12)
    Ggnt  = BigPow(10, 9)
    Mgnt  = BigPow(10, 6)
    Kgnt  = BigPow(10, 3)
    gnt   = big.NewInt(1)
	Douglas  = BigPow(10, 42)
	Einstein = BigPow(10, 21)
	Ether    = BigPow(10, 18)
	Finney   = BigPow(10, 15)
	Szabo    = BigPow(10, 12)
	Shannon  = BigPow(10, 9)
	Babbage  = BigPow(10, 6)
	Ada      = BigPow(10, 3)
	Wei      = big.NewInt(1)
)

//
// Currency to string
// Returns a string representing a human readable format
func CurrencyToString(num *big.Int) string {
	var (
		fin   *big.Int = num
		denom string   = "Wei"
	)

	switch {
    case num.Cmp(Xgnt) >= 0:
        fin = new(big.Int).Div(num, Xgnt)
        denom = "Xgnt"
    case num.Cmp(Zgnt) >= 0:
        fin = new(big.Int).Div(num, Zgnt)
        denom = "Zgnt"
    case num.Cmp(Egnt) >= 0:
        fin = new(big.Int).Div(num, Egnt)
        denom = "Egnt"
    case num.Cmp(Pgnt) >= 0:
        fin = new(big.Int).Div(num, Pgnt)
        denom = "Pgnt"
    case num.Cmp(Tgnt) >= 0:
        fin = new(big.Int).Div(num, Tgnt)
        denom = "Tgnt"
    case num.Cmp(Ggnt) >= 0:
        fin = new(big.Int).Div(num, Ggnt)
        denom = "Ggnt"
    case num.Cmp(Mgnt) >= 0:
        fin = new(big.Int).Div(num, Mgnt)
        denom = "Mgnt"
    case num.Cmp(Kgnt) >= 0:
        fin = new(big.Int).Div(num, Kgnt)
        denom = "Kgnt"

	}

	return fmt.Sprintf("%v %s", fin, denom)
}
