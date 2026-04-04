from setuptools import find_packages, setup

package_name = 'flapping_foil_propulsors_control'

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='shafayat',
    maintainer_email='shafayatalam2004@gmail.com',
    description='TODO: Package description',
    license='TODO: License declaration',
    extras_require={
        'test': [
            'pytest',
        ],
    },
    entry_points={
        'console_scripts': [
            'Dynamixcel_WX430_T200_interface = flapping_foil_propulsors_control.Dynamixcel_WX430_T200_interface:main',
            'CrabController2DOF = flapping_foil_propulsors_control.CrabController2DOF:main',
            'crab = flapping_foil_propulsors_control.crab:main',
        ],
    },
)
