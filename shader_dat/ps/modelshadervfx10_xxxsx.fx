float4 CubeParam : register(c42);
sampler RefractMap_sampler : register(s12);
float4 Refract_Param : register(c43);
float4 SoftPt_Rate : register(c44);
float4 ambient_rate : register(c40);
float4 finalcolor_enhance : register(c78);
float3 fog : register(c67);
float4 g_CameraParam : register(c193);
float4 g_TargetUvParam : register(c194);
sampler g_Z_sampler : register(s13);
float4 lightpos : register(c62);
sampler normalmap_sampler : register(s2);
float4 prefogcolor_enhance : register(c77);
float4 tile : register(c45);

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
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
	r0.zw = float2(0.5, -0.5);
	r0.x = (SoftPt_Rate.x >= 0) ? r0.w : r0.z;
	r0.y = (-SoftPt_Rate.x >= 0) ? -r0.w : -r0.z;
	r0.x = r0.y + r0.x;
	r0.x = (r0.x >= 0) ? -r0.x : -0;
	r0.y = 1 / i.texcoord8.w;
	r1.xy = r0.yy * i.texcoord8.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r2 = tex2D(g_Z_sampler, r1);
	r0.y = r2.x * g_CameraParam.y + g_CameraParam.x;
	r0.y = r0.y + -i.texcoord8.w;
	r1.z = abs(SoftPt_Rate.x);
	r1.z = 1 / r1.z;
	r0.y = r0.y * r1.z;
	r1.z = -r0.y + 1;
	r0.x = (r0.x >= 0) ? r0.y : r1.z;
	r2 = float4(-0, -0, -0, -1) + i.color;
	r2 = SoftPt_Rate.y * r2 + r0.wwwz;
	r0.y = r2.w * ambient_rate.w;
	r3 = r0.y * r0.x + -0.01;
	r0.x = r0.x * r0.y;
	r0.w = r0.x * prefogcolor_enhance.w;
	clip(r3);
	r3.xyz = i.texcoord3.xyz;
	r4.xyz = r3.yzx * i.texcoord2.zxy;
	r3.xyz = i.texcoord2.yzx * r3.zxy + -r4.xyz;
	r1.zw = i.texcoord.zw * tile.xy + tile.zw;
	r4 = tex2D(normalmap_sampler, r1.zwzw);
	r4.xyz = r4.xyz + -0.5;
	r3.xyz = r3.xyz * -r4.yyy;
	r1.z = r4.x * i.texcoord2.w;
	r3.xyz = r1.zzz * i.texcoord2.xyz + r3.xyz;
	r3.xyz = r4.zzz * i.texcoord3.xyz + r3.xyz;
	r1.z = dot(r3.xyz, r3.xyz);
	r1.z = 1 / sqrt(r1.z);
	r3.xyz = r3.xyz * r1.zzz + -i.texcoord3.xyz;
	r1.zw = CubeParam.ww * r3.xy + i.texcoord3.xy;
	r3.xyz = r3.xyz * CubeParam.www;
	r3.xyz = Refract_Param.zzz * r3.xyz + i.texcoord3.xyz;
	r2.w = dot(lightpos.xyz, r3.xyz);
	r1.xy = r1.zw * -Refract_Param.yy + r1.xy;
	r1 = tex2D(RefractMap_sampler, r1);
	r3.xyz = lerp(r1.xyz, r2.xyz, Refract_Param.xxx);
	r1.xyz = r3.xyz * ambient_rate.xyz;
	r1.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.w = -r1.w + r2.w;
	r1.w = r1.w * 0.5 + 1;
	r1.xyz = r1.www * r1.xyz;
	r2.xyz = fog.xyz;
	r1.xyz = r1.xyz * prefogcolor_enhance.xyz + -r2.xyz;
	r0.xyz = i.texcoord1.www * r1.xyz + fog.xyz;
	o = r0 * finalcolor_enhance;

	return o;
}
