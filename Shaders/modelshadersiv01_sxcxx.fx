sampler Color_1_sampler;
float4 CubeParam;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
samplerCUBE cubemap_sampler;
float3 fog;
float4 g_All_Offset;
float g_ShadowUse;
float4 g_TargetUvParam;
sampler normalmap_sampler;
float4 prefogcolor_enhance;
float4 tile;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1 = r0.w + -0.8;
	clip(r1);
	r1.xy = -r0.yy + r0.xz;
	r0.w = max(abs(r1.x), abs(r1.y));
	r0.w = r0.w + -0.015625;
	r1.x = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.x;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r0.xz = (r0.ww >= 0) ? r0.yy : r0.xz;
	r0.w = 1 / ambient_rate.w;
	r0.xyz = r0.www * r0.xyz;
	r0.w = 1 / i.texcoord7.w;
	r1.xy = r0.ww * i.texcoord7.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(Shadow_Tex_sampler, r1);
	r0.w = r1.z + g_ShadowUse.x;
	r1.xyz = ambient_rate_rate.xyz;
	r1.xyz = r0.www * r1.xyz + ambient_rate.xyz;
	r1.xyz = r1.xyz + i.texcoord2.xyz;
	r1.xyz = r0.xyz * r1.xyz;
	r2.xy = g_All_Offset.xy;
	r2.xy = i.texcoord.xy * tile.xy + r2.xy;
	r2 = tex2D(normalmap_sampler, r2);
	r3 = tex2D(cubemap_sampler, i.texcoord4);
	r3 = r3 * ambient_rate_rate.w;
	r2.xyz = r2.www * r3.xyz;
	r0.w = r3.w * CubeParam.y + CubeParam.x;
	r2.xyz = r0.www * r2.xyz;
	r0.xyz = r0.xyz * r2.xyz;
	r3.xyz = r0.xyz * CubeParam.zzz + r1.xyz;
	r0.xyz = r0.xyz * CubeParam.zzz;
	r0.xyz = r1.xyz * -r0.xyz + r3.xyz;
	r1.z = CubeParam.z;
	r0.w = -r1.z + 1;
	r0.xyz = r2.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
