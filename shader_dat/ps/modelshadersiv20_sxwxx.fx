sampler A_Occ_sampler;
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
float4 light_Color;
float4 lightpos;
float4 prefogcolor_enhance;

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
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
	float3 r4;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r0.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.xyz = r0.yyy * light_Color.xyz;
	r0.y = r0.y + -0.5;
	r1.w = max(r0.y, 0);
	r0.xyz = r1.xyz * r0.xxx + i.texcoord2.xyz;
	r2 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r3 = tex2D(A_Occ_sampler, r2);
	r2 = tex2D(Color_1_sampler, r2.zwzw);
	r1.xy = -r3.yy + r3.xz;
	r0.w = max(abs(r1.x), abs(r1.y));
	r0.w = r0.w + -0.015625;
	r1.x = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.x;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r3.xz = (r0.ww >= 0) ? r3.yy : r3.xz;
	r1.xyz = r1.www + r3.xyz;
	r4.xy = -r2.yy + r2.xz;
	r0.w = max(abs(r4.x), abs(r4.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r2.xz = (r0.ww >= 0) ? r2.yy : r2.xz;
	r4.xyz = r1.xyz * r2.xyz;
	r0.xyz = r0.xyz * r4.xyz;
	r3.xyz = r3.xyz * r2.xyz;
	r3.xyz = r3.xyz * ambient_rate.xyz;
	r0.xyz = r3.xyz * ambient_rate_rate.xyz + r0.xyz;
	r3 = tex2D(cubemap_sampler, i.texcoord4);
	r3 = r3 * ambient_rate_rate.w;
	r3.xyz = r2.www * r3.xyz;
	r0.w = r3.w * CubeParam.y + CubeParam.x;
	r3.xyz = r0.www * r3.xyz;
	r1.xyz = r1.xyz * r3.xyz;
	r2.xyz = r2.xyz * r1.xyz;
	r3.xyz = r2.xyz * CubeParam.zzz + r0.xyz;
	r2.xyz = r2.xyz * CubeParam.zzz;
	r0.xyz = r0.xyz * -r2.xyz + r3.xyz;
	r2.y = 1;
	r0.w = r2.y + -CubeParam.z;
	r0.xyz = r1.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
