from setuptools import find_packages, setup
import os                      
from glob import glob          

package_name = 'flapping_foil_propulsors_control'

setup(
    name=package_name,
    version='0.0.0',
    packages=[package_name],  # Changed from find_packages()
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
        (os.path.join('share', package_name, 'launch'), glob(os.path.join('launch', '*.py'))),
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
            'Dynamixcel_XW430_T200_interface = flapping_foil_propulsors_control.Dynamixcel_XW430_T200_interface:main',
            'CrabController2DOF = flapping_foil_propulsors_control.CrabController2DOF:main',
            'crab = flapping_foil_propulsors_control.crab:main',
        ],
    },
)