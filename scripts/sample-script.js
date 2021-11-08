const main = async () => {
	const [deployer] = await hre.ethers.getSigners();
	const accountBalance = await deployer.getBalance();

	console.log("Deploying Contracts with --> " + deployer.address);
	console.log("Account Balance --> " + accountBalance);

	const Token = await hre.ethers.getContractFactory("MyStreamContract");
	const portal = await Token.deploy({
		value: hre.ethers.utils.parseEther('0.1'),
	});
	await portal.deployed();
	
	let contractBalance = await hre.ethers.provider.getBalance(
		portal.address
	)
	console.log("Contract Balance: ", hre.ethers.utils.formatEther(contractBalance))
	
	
	contractBalance = await hre.ethers.provider.getBalance(
		portal.address
	)
	
	let bro = await portal.bro("Yo, Vro")
	await portal.deployed()
	console.log("Contract Balance: ", hre.ethers.utils.formatEther(contractBalance))
	
	bro = await portal.bro("Yo, Vro")
	await portal.deployed()
	console.log("Contract Balance2: ", hre.ethers.utils.formatEther(contractBalance))
	
	let getbros = await portal.getAllBros()
	await portal.deployed()
	contractBalance = await hre.ethers.provider.getBalance(
		portal.address
	)

	console.log("Contract Address --> " + portal.address)
	console.log("Account Balance --> " + await deployer.getBalance())
}

const runMain = async () => {
	try {
		await main();
		process.exit(0);
	} catch (error) {
		console.error(error);
		process.exit(1);
	}
}

runMain()