sampler Color_1_sampler : register(s0);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
float aniso_diff_rate : register(c49);
float aniso_shine : register(c50);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float hll_rate : register(c43);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 muzzle_light : register(c69);
float4 muzzle_lightpos : register(c70);
float4 point_light1 : register(c63);
float4 point_lightpos1 : register(c64);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
sampler specularmap_sampler : register(s2);
float ss_scat_pow : register(c46);
float ss_scat_rate : register(c44);

struct PS_IN
{
	float3 color : COLOR;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float3 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float3 r5;
	float3 r6;
	r0.x = 1 / i.texcoord8.w;
	r0.xy = r0.xx * i.texcoord8.xy;
	r0.zw = r0.xy * float2(1280, 720);
	r1.xy = frac(r0.zw);
	r0.zw = r0.zw + -r1.xy;
	r1.xy = (-r1.xy >= 0) ? 0 : 1;
	r0.xy = (r0.xy >= 0) ? 0 : r1.xy;
	r0.xy = r0.xy + r0.zw;
	r1 = (r0.xxyy >= 0) ? float4(8, 0.125, 8, 0.125) : float4(-8, -0.125, -8, -0.125);
	r0.xy = r0.xy * r1.yw;
	r0.xy = frac(r0.xy);
	r0.xy = r0.xy * r1.xz;
	r0.zw = frac(r0.xy);
	r1.xy = (-r0.zw >= 0) ? 0 : 1;
	r0.zw = r0.xy + -r0.zw;
	r0.xy = (r0.xy >= 0) ? 0 : r1.xy;
	r0.xy = r0.xy + r0.zw;
	r0.x = r0.y * 8 + r0.x;
	r1 = r0.x + float4(-1, -2, -3, -4);
	r0.y = (-abs(r1.x) >= 0) ? -0.25 : -0;
	r0.y = (-abs(r1.y) >= 0) ? -0.0625 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.3125 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.015625 : r0.y;
	r1 = r0.x + float4(-5, -6, -7, -8);
	r0.y = (-abs(r1.x) >= 0) ? -0.265625 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.078125 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.328125 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.375 : r0.y;
	r1 = r0.x + float4(-9, -10, -11, -12);
	r0.y = (-abs(r1.x) >= 0) ? -0.125 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.4375 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.1875 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.390625 : r0.y;
	r1 = r0.x + float4(-13, -14, -15, -16);
	r0.y = (-abs(r1.x) >= 0) ? -0.140625 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.453125 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.203125 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.09375 : r0.y;
	r1 = r0.x + float4(-17, -18, -19, -20);
	r0.y = (-abs(r1.x) >= 0) ? -0.34375 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.03125 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.28125 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.109375 : r0.y;
	r1 = r0.x + float4(-21, -22, -23, -24);
	r0.y = (-abs(r1.x) >= 0) ? -0.359375 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.046875 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.296875 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.46875 : r0.y;
	r1 = r0.x + float4(-25, -26, -27, -28);
	r0.y = (-abs(r1.x) >= 0) ? -0.21875 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.40625 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.15625 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.484375 : r0.y;
	r1 = r0.x + float4(-29, -30, -31, -32);
	r0.y = (-abs(r1.x) >= 0) ? -0.234375 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.421875 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.171875 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.0234375 : r0.y;
	r1 = r0.x + float4(-33, -34, -35, -36);
	r0.y = (-abs(r1.x) >= 0) ? -0.2734375 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.0859375 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.3359375 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.0078125 : r0.y;
	r1 = r0.x + float4(-37, -38, -39, -40);
	r0.y = (-abs(r1.x) >= 0) ? -0.2578125 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.0703125 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.3203125 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.3984375 : r0.y;
	r1 = r0.x + float4(-41, -42, -43, -44);
	r0.y = (-abs(r1.x) >= 0) ? -0.1484375 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.4609375 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.2109375 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.3828125 : r0.y;
	r1 = r0.x + float4(-45, -46, -47, -48);
	r0.y = (-abs(r1.x) >= 0) ? -0.1328125 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.4453125 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.1953125 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.1171875 : r0.y;
	r1 = r0.x + float4(-49, -50, -51, -52);
	r0.y = (-abs(r1.x) >= 0) ? -0.3671875 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.0546875 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.3046875 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.1015625 : r0.y;
	r1 = r0.x + float4(-53, -54, -55, -56);
	r0.y = (-abs(r1.x) >= 0) ? -0.3515625 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.0390625 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.2890625 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.4921875 : r0.y;
	r1 = r0.x + float4(-57, -58, -59, -60);
	r0.xzw = r0.xxx + float3(-61, -62, -62);
	r0.y = (-abs(r1.x) >= 0) ? -0.2421875 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.4296875 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.1796875 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.4765625 : r0.y;
	r0.x = (-abs(r0.x) >= 0) ? -0.2265625 : r0.y;
	r0.x = (-abs(r0.z) >= 0) ? -0.4140625 : r0.x;
	r0.x = (-abs(r0.w) >= 0) ? -0.1640625 : r0.x;
	r0.yz = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(Color_1_sampler, r0.yzzw);
	r2 = tex2D(specularmap_sampler, r0.yzzw);
	r0 = r0.x + r1.w;
	clip(r0);
	r0.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	r0.xyz = r0.www * r0.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + point_lightpos1.w;
	r0.w = r0.w * point_light1.w;
	r0.x = dot(r0.xyz, i.texcoord3.xyz);
	r0.y = r0.x * 0.5 + 0.5;
	r0.y = r0.y * r0.y;
	r1.w = lerp(r0.y, r0.x, hll_rate.x);
	r0.xyz = r1.www * point_light1.xyz;
	r0.xyz = r0.www * r0.xyz;
	r3.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r0.w = dot(r3.xyz, r3.xyz);
	r0.w = 1 / sqrt(r0.w);
	r3.xyz = r0.www * r3.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + muzzle_lightpos.w;
	r0.w = r0.w * muzzle_light.w;
	r1.w = dot(r3.xyz, i.texcoord3.xyz);
	r2.w = r1.w * 0.5 + 0.5;
	r2.w = r2.w * r2.w;
	r3.x = lerp(r2.w, r1.w, hll_rate.x);
	r3.xyz = r3.xxx * muzzle_light.xyz;
	r0.xyz = r3.xyz * r0.www + r0.xyz;
	r0.w = 1 / i.texcoord7.w;
	r3.xy = r0.ww * i.texcoord7.xy;
	r3.xy = r3.xy * float2(0.5, -0.5) + 0.5;
	r3.xy = r3.xy + g_TargetUvParam.xy;
	r3 = tex2D(Shadow_Tex_sampler, r3);
	r0.w = r3.z + g_ShadowUse.x;
	r3.xyz = i.texcoord1.xyz;
	r3.y = dot(r3.xyz, -i.texcoord3.xyz);
	r3.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r3.yz = r0.ww * r3.xy;
	r3.yz = r3.yz * -0.5 + 1;
	r4.xy = r3.yz * r3.yz;
	r4.xy = r4.xy * r4.xy;
	r3.yz = r3.yz * -r4.xy + 1;
	r1.w = r3.z * r3.y;
	r2.w = r1.w * 0.193754 + 0.5;
	r1.w = r1.w * 0.387508;
	r2.w = r2.w * r2.w + -r1.w;
	r1.w = hll_rate.x * r2.w + r1.w;
	r4.xyz = light_Color.xyz;
	r3.yzw = r4.xyz * aniso_diff_rate.xxx;
	r0.xyz = r3.yzw * r1.www + r0.xyz;
	r3.yz = -r1.yy + r1.xz;
	r1.w = max(abs(r3.y), abs(r3.z));
	r1.w = r1.w + -0.015625;
	r2.w = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r2.w;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r1.xz = (r1.ww >= 0) ? r1.yy : r1.xz;
	r0.xyz = r0.xyz * r1.xyz;
	r3.yzw = r1.xyz * ambient_rate.xyz;
	r0.xyz = r3.yzw * ambient_rate_rate.xyz + r0.xyz;
	r1.w = (-r3.x >= 0) ? 0 : 1;
	r2.w = r3.x * r1.w;
	r3.xyz = r2.www * light_Color.xyz;
	r4.xyz = i.texcoord3.xyz;
	r5.xyz = r4.yzx * i.texcoord2.zxy;
	r4.xyz = i.texcoord2.yzx * r4.zxy + -r5.xyz;
	r5.xyz = lightpos.xyz + -i.texcoord1.xyz;
	r6.xyz = normalize(r5.xyz);
	r2.w = dot(r6.xyz, r4.xyz);
	r4.y = 1;
	r2.w = abs(r2.w) * -aniso_shine.x + r4.y;
	r3.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r3.w = 1 / sqrt(r3.w);
	r4.xzw = -i.texcoord1.xyz * r3.www + lightpos.xyz;
	r5.xyz = normalize(r4.xzw);
	r3.w = dot(r5.xyz, i.texcoord3.xyz);
	r2.w = r2.w * r3.w;
	r1.w = (-r2.w >= 0) ? 0 : r1.w;
	r3.w = pow(r2.w, specularParam.z);
	r1.w = r1.w * r3.w;
	r3.xyz = r1.www * r3.xyz;
	r2.xyz = r2.xyz * r3.xyz;
	r2.xyz = r0.www * r2.xyz;
	r0.w = abs(specularParam.x);
	r2.xyz = r0.www * r2.xyz;
	r3.xyz = r1.xyz + specularParam.www;
	r2.xyz = r2.xyz * r3.xyz;
	r0.xyz = r2.xyz * i.color.xxx + r0.xyz;
	r0.w = 1 + -i.texcoord3.z;
	r1.xyz = r0.www * r1.xyz;
	r0.w = r0.w + -ss_scat_rate.x;
	r1.xyz = r1.xyz * ss_scat_pow.xxx;
	r1.w = r4.y + -ss_scat_rate.x;
	r1.w = 1 / r1.w;
	r1.w = r0.w * r1.w;
	r0.w = r0.w;
	r2.x = frac(-r0.w);
	r0.w = r0.w + r2.x;
	r0.w = r0.w * r1.w;
	r1.xyz = r0.www * r1.xyz;
	r0.xyz = r0.xyz * i.color.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
