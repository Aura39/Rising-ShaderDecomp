float4 CubeParam;
sampler RefractMap_sampler;
float4 Refract_Param;
float4 SoftPt_Rate;
float4 ambient_rate;
float4 finalcolor_enhance;
float3 fog;
float4 g_CameraParam;
float4 g_TargetUvParam;
sampler g_Z_sampler;
float4 lightpos;
sampler nkiMask_sampler;
float4 nkiTile;
sampler normalmap_sampler;
float4 prefogcolor_enhance;
float4 tile;

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
	r1.zw = i.texcoord.zw * nkiTile.xy + nkiTile.zw;
	r2 = tex2D(nkiMask_sampler, r1.zwzw);
	r3 = float4(-0, -0, -0, -1) + i.color;
	r3 = SoftPt_Rate.y * r3 + r0.wwwz;
	r0.y = r2.w * r3.w;
	r0.y = r0.y * ambient_rate.w;
	r2 = r0.y * r0.x + -0.01;
	r0.x = r0.x * r0.y;
	r0.w = r0.x * prefogcolor_enhance.w;
	clip(r2);
	r2.xyz = i.texcoord3.xyz;
	r4.xyz = r2.yzx * i.texcoord2.zxy;
	r2.xyz = i.texcoord2.yzx * r2.zxy + -r4.xyz;
	r1.zw = i.texcoord.zw * tile.xy + tile.zw;
	r4 = tex2D(normalmap_sampler, r1.zwzw);
	r4.xyz = r4.xyz + -0.5;
	r2.xyz = r2.xyz * -r4.yyy;
	r1.z = r4.x * i.texcoord2.w;
	r2.xyz = r1.zzz * i.texcoord2.xyz + r2.xyz;
	r2.xyz = r4.zzz * i.texcoord3.xyz + r2.xyz;
	r1.z = dot(r2.xyz, r2.xyz);
	r1.z = 1 / sqrt(r1.z);
	r2.xyz = r2.xyz * r1.zzz + -i.texcoord3.xyz;
	r1.zw = CubeParam.ww * r2.xy + i.texcoord3.xy;
	r2.xyz = r2.xyz * CubeParam.www;
	r2.xyz = Refract_Param.zzz * r2.xyz + i.texcoord3.xyz;
	r2.x = dot(lightpos.xyz, r2.xyz);
	r1.xy = r1.zw * -Refract_Param.yy + r1.xy;
	r1 = tex2D(RefractMap_sampler, r1);
	r2.yzw = lerp(r1.xyz, r3.xyz, Refract_Param.xxx);
	r1.xyz = r2.yzw * ambient_rate.xyz;
	r1.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.w = -r1.w + r2.x;
	r1.w = r1.w * 0.5 + 1;
	r1.xyz = r1.www * r1.xyz;
	r2.xyz = fog.xyz;
	r1.xyz = r1.xyz * prefogcolor_enhance.xyz + -r2.xyz;
	r0.xyz = i.texcoord1.www * r1.xyz + fog.xyz;
	o = r0 * finalcolor_enhance;

	return o;
}
