sampler Color_1_sampler : register(s0);
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
sampler nkiMask_sampler : register(s3);
float4 nkiTile : register(c46);
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
	r0.xy = i.texcoord.zw * nkiTile.xy + nkiTile.zw;
	r0 = tex2D(nkiMask_sampler, r0);
	r1 = tex2D(Color_1_sampler, i.texcoord);
	r0.x = r0.w * r1.w;
	r0.w = ambient_rate.w;
	r2 = r0.x * r0.w + -0.01;
	r0.w = r0.x * ambient_rate.w;
	clip(r2);
	r2.xy = -r1.yy + r1.xz;
	r1.w = max(abs(r2.x), abs(r2.y));
	r1.w = r1.w + -0.015625;
	r2.x = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r2.x;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r1.xz = (r1.ww >= 0) ? r1.yy : r1.xz;
	r2.xyz = i.texcoord3.xyz;
	r3.xyz = r2.yzx * i.texcoord2.zxy;
	r2.xyz = i.texcoord2.yzx * r2.zxy + -r3.xyz;
	r3.xy = i.texcoord.zw * tile.xy + tile.zw;
	r3 = tex2D(normalmap_sampler, r3);
	r3.xyz = r3.xyz + -0.5;
	r2.xyz = r2.xyz * -r3.yyy;
	r1.w = r3.x * i.texcoord2.w;
	r2.xyz = r1.www * i.texcoord2.xyz + r2.xyz;
	r2.xyz = r3.zzz * i.texcoord3.xyz + r2.xyz;
	r1.w = dot(r2.xyz, r2.xyz);
	r1.w = 1 / sqrt(r1.w);
	r2.xyz = r2.xyz * r1.www + -i.texcoord3.xyz;
	r3.xy = CubeParam.ww * r2.xy + i.texcoord3.xy;
	r2.xyz = r2.xyz * CubeParam.www;
	r2.xyz = Refract_Param.zzz * r2.xyz + i.texcoord3.xyz;
	r1.w = dot(lightpos.xyz, r2.xyz);
	r2.x = 1 / i.texcoord8.w;
	r2.xy = r2.xx * i.texcoord8.xy;
	r2.xy = r2.xy * float2(0.5, -0.5) + 0.5;
	r2.xy = r2.xy + g_TargetUvParam.xy;
	r2.zw = r3.xy * -Refract_Param.yy + r2.xy;
	r3 = tex2D(g_Z_sampler, r2.zwzw);
	r3.x = r3.x * g_CameraParam.y + g_CameraParam.x;
	r3.x = -r3.x + abs(i.texcoord1.z);
	r2.xy = (-r3.xx >= 0) ? r2.zw : r2.xy;
	r2 = tex2D(RefractMap_sampler, r2);
	r3.xyz = lerp(r2.xyz, r1.xyz, Refract_Param.xxx);
	r1.xyz = r3.xyz * ambient_rate.xyz;
	r2.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.w = r1.w + -r2.x;
	r1.w = r1.w * 0.5 + 1;
	r0.xyz = r1.www * r1.xyz;
	r1 = -1 + i.color;
	r2.y = 1;
	r1 = SoftPt_Rate.y * r1 + r2.y;
	r0 = r0 * r1;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	r1.w = r0.w * prefogcolor_enhance.w;
	r1.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o = r1 * finalcolor_enhance;

	return o;
}
