sampler A_Occ_sampler;
sampler Color_1_sampler;
sampler Color_2_sampler;
float4 CubeParam;
sampler Shadow_Tex_sampler;
sampler Spec_Pow_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
samplerCUBE cubemap_sampler;
float3 fog;
float4 g_All_Offset;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 light_Color;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
float4 point_light1;
float4 point_lightpos1;
float4 prefogcolor_enhance;
float4 specularParam;
float4 tile;

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
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
	float4 r6;
	float3 r7;
	r0.xy = g_All_Offset.xy;
	r0.xy = i.texcoord.xy * tile.zw + r0.xy;
	r0 = tex2D(Color_2_sampler, r0);
	r1.xy = -r0.yy + r0.xz;
	r2.x = max(abs(r1.x), abs(r1.y));
	r1.x = r2.x + -0.015625;
	r1.y = (-r1.x >= 0) ? 0 : 1;
	r1.x = (r1.x >= 0) ? -0 : -1;
	r1.x = r1.x + r1.y;
	r1.x = (r1.x >= 0) ? -r1.x : -0;
	r0.xz = (r1.xx >= 0) ? r0.yy : r0.xz;
	r1 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r2 = tex2D(Color_1_sampler, r1.zwzw);
	r1 = tex2D(A_Occ_sampler, r1);
	r3.xy = -r2.yy + r2.xz;
	r1.w = max(abs(r3.x), abs(r3.y));
	r1.w = r1.w + -0.015625;
	r3.x = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r3.x;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r2.xz = (r1.ww >= 0) ? r2.yy : r2.xz;
	r1.w = r0.w * i.color.w;
	r0.w = r0.w * -i.color.w + 1;
	r3.xyz = lerp(r0.xyz, r2.xyz, r1.www);
	r0.x = 1 / ambient_rate.w;
	r0.xyz = r0.xxx * r3.xyz;
	r2.xyz = r0.xyz * i.color.xyz;
	r0.xyz = r0.xyz * i.color.xyz + specularParam.www;
	r3 = tex2D(cubemap_sampler, i.texcoord4);
	r3 = r0.w * r3;
	r4.xy = -r1.yy + r1.xz;
	r0.w = max(abs(r4.x), abs(r4.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r1.xz = (r0.ww >= 0) ? r1.yy : r1.xz;
	r3.xyz = r1.xyz * r3.xyz;
	r3 = r3 * ambient_rate_rate.w;
	r3.xyz = r2.www * r3.xyz;
	r0.w = r3.w * CubeParam.y + CubeParam.x;
	r3.xyz = r0.www * r3.xyz;
	r4.xyz = r2.xyz * r3.xyz;
	r5.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r6.xyz = normalize(r5.xyz);
	r0.w = dot(r6.xyz, i.texcoord3.xyz);
	r5.xyz = r0.www * point_light1.xyz;
	r5.xyz = r5.xyz * i.texcoord8.xxx;
	r6.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r7.xyz = normalize(r6.xyz);
	r0.w = dot(r7.xyz, i.texcoord3.xyz);
	r6.xyz = r0.www * muzzle_light.xyz;
	r5.xyz = r6.xyz * i.texcoord8.zzz + r5.xyz;
	r0.w = 1 / i.texcoord7.w;
	r6.xy = r0.ww * i.texcoord7.xy;
	r6.xy = r6.xy * float2(0.5, -0.5) + 0.5;
	r6.xy = r6.xy + g_TargetUvParam.xy;
	r6 = tex2D(Shadow_Tex_sampler, r6);
	r0.w = r6.z + g_ShadowUse.x;
	r6.xyz = ambient_rate_rate.xyz;
	r6.xyz = r0.www * r6.xyz + ambient_rate.xyz;
	r5.xyz = r1.xyz * r6.xyz + r5.xyz;
	r2.xyz = r2.xyz * r5.xyz;
	r5.xyz = r4.xyz * CubeParam.zzz + r2.xyz;
	r4.xyz = r4.xyz * CubeParam.zzz;
	r2.xyz = r2.xyz * -r4.xyz + r5.xyz;
	r1.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.w = 1 / sqrt(r1.w);
	r4.xyz = -i.texcoord1.xyz * r1.www + lightpos.xyz;
	r5.xyz = normalize(r4.xyz);
	r1.w = dot(r5.xyz, i.texcoord3.xyz);
	r3.w = -r1.w + 1;
	r4.x = r3.w * -specularParam.z + r1.w;
	r4.y = specularParam.y;
	r4 = tex2D(Spec_Pow_sampler, r4);
	r4.xyz = r4.xyz * light_Color.xyz;
	r4.xyz = r2.www * r4.xyz;
	r4.xyz = r0.www * r4.xyz;
	r1.xyz = r1.xyz * r4.xyz;
	r0.w = abs(specularParam.x);
	r1.xyz = r0.www * r1.xyz;
	r0.xyz = r1.xyz * r0.xyz + r2.xyz;
	r1.y = 1;
	r0.w = r1.y + -CubeParam.z;
	r0.xyz = r3.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}