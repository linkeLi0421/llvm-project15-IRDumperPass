#include <assert.h>
#include <stdio.h>

#include <iostream>
#include <map>
#include <vector>
#include <set>

#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InlineAsm.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Pass.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/InitializePasses.h"
#include "llvm/CodeGen/Passes.h"



using namespace llvm;

namespace{
	class IRDumper : public ModulePass {

	public:
		static char ID;
		IRDumper() : ModulePass(ID) {
			initializeIRDumperPass(*PassRegistry::getPassRegistry());
		}
		virtual bool runOnModule(Module &M);
	};
}

void saveModule(Module &M, Twine filename)
{
	//int ll_fd;
	//sys::fs::openFileForWrite(filename + "_pt.ll", ll_fd, 
	//		sys::fs::F_RW | sys::fs::F_Text);
	//raw_fd_ostream ll_file(ll_fd, true, true);
	//M.print(ll_file, nullptr);

	int bc_fd;
	sys::fs::openFileForWrite(filename + "_pt.bc", bc_fd);
	raw_fd_ostream bc_file(bc_fd, true, true);
	WriteBitcodeToFile(M, bc_file);
}

bool IRDumper::runOnModule(Module &M) {

	saveModule(M, M.getName());

	return true;
}

char IRDumper::ID = 0;


INITIALIZE_PASS(IRDumper, "IRDumper",
                "save IR to .bc file", false, false)

ModulePass *llvm::createIRDumperPass() {
  return new IRDumper();
} 